module TheWhere
  module Order

    def order_scope(params)
      order_array = []

      params.select{ |key, _| key.end_with?('-asc') }.each do |k, _|
        order_array << k.sub(/-asc$/, ' ASC')
      end

      params.select{ |key, _| key.end_with?('-desc') }.each do |k, _|
        order_array << k.sub(/-desc$/, ' DESC')
      end

      order(order_array)
    end

    def filter_order(params)
      params.select do |k, v|
        k.end_with?('-asc', '-desc') && v =~ /^[1-9]$/
      end
    end

  end
end
