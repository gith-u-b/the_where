module TheWhere
  module Like

    def like_scope(params)
      where_string = []
      where_hash = {}

      params.select{ |k, _| k.end_with?('-like') }.each do |key, value|
        real_key = key.sub(/-like$/, '')
        agent_key = key.gsub(/[-\.]/, '_')

        where_string << "#{real_key} like :#{agent_key}"
        where_hash.merge! agent_key.to_sym => '%' + value.to_s + '%'
      end

      where_string = where_string.join ' AND '

      if where_string.present?
        condition = [where_string, where_hash]
        where(condition)
      else
        all
      end
    end

    def filter_like(params)
      params.select do |k, _|
        k.end_with?('-like')
      end
    end

  end
end
