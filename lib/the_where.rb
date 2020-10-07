require 'the_where/not'
require 'the_where/range'
require 'the_where/like'
require 'the_where/order'

module TheWhere
  include TheWhere::Not
  include TheWhere::Range
  include TheWhere::Order
  include TheWhere::Like

  REJECT = ['', ' ', nil]
  STRIP = true

  def the_where(params = {}, options = {})
    return all if params.blank?

    params, refs, tables = params_with_table(params, options)

    range_params = filter_range(params)
    order_params = filter_order(params)
    not_params = filter_not(params)
    like_params = filter_like(params)

    equal_params = params.except!(*range_params.keys, *order_params.keys, *not_params.keys, *like_params.keys)

    includes(refs).where(equal_params).references(tables)
      .not_scope(not_params)
      .like_scope(like_params)
      .range_scope(range_params)
      .order_scope(order_params)
  end

  def params_with_table(params = {}, options = {})
    if options[:reject]
      default_reject = [options[:reject]].flatten
    elsif options[:allow]
      default_reject = REJECT - [options[:allow]].flatten
    else
      default_reject = REJECT
    end

    unless options.has_key? :strip
      options[:strip] = STRIP
    end

    params = params.to_h
    params.stringify_keys!
    params.reject! { |_, value| default_reject.include?(value) }

    refs = []
    tables = []
    final_params = {}

    params.each do |key, value|
      value = value.strip if value.is_a?(String) && options[:strip]

      if key =~ /\./
        table, col = key.split('.')
        as_model = reflections[table]
        f_col, _ = col.split('-')

        if as_model && as_model.klass.column_names.include?(f_col)
          final_params["#{as_model.table_name}.#{col}"] = value
          tables << as_model.table_name
          refs << table.to_sym
        elsif connection.data_sources.include? table
          final_params["#{table}.#{col}"] = value
          tables << table
          keys = reflections.select { |_, v| !v.polymorphic? && v.table_name == table }.keys
          if keys && keys.size == 1
            refs << keys.first.to_sym
          end
        end
      else
        f_key, _ = key.split('-')
        if column_names.include?(f_key)
          final_params["#{table_name}.#{key}"] = value
        end
      end
    end

    [final_params, refs, tables]
  end

end

ActiveRecord::Base.extend TheWhere
