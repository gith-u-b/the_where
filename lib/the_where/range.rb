module TheWhere
  module Range

    PATTERN = {
      '-gt' => '>',
      '-gte' => '>=',
      '-lt' => '<',
      '-lte' => '<='
    }

    def range_scope(params)
      where_string = []
      where_hash = {}

      PATTERN.each do |char, sign|
        options = params.select{ |key, _| key.end_with?(char) }

        options.each do |key, value|
          exp = Regexp.new(char + '$')
          real_key = key.sub(exp, '')
          agent_key = key.gsub(/[-\.]/, '_')

          where_string << "#{real_key} #{sign} :#{agent_key}"

          where_hash.merge! agent_key.to_sym => value
        end
      end

      where_string = where_string.join ' AND '

      if where_string.present?
        condition = [where_string, where_hash]
        where(condition)
      else
        all
      end
    end

    def filter_range(params)
      params.select do |k, _|
        k.end_with?(*PATTERN.keys)
      end
    end

  end
end
