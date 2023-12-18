module MyApplacationSelin
  class Item
    def initialize(name, min_price, max_price, params)
      @max_price, @min_price, @name = max_price, min_price, name
      params.each do |k, v|
        self.instance_variable_set "@#{k}", v
      end
    end
    attr_accessor :name, :min_price, :max_price

    include Comparable

    def to_s
      result = 'Item: '
      instance_variables.each do |var|
        result += "#{var.to_s}: #{instance_variable_get var}, "
      end
      return result
    end

    def to_h
      result = {}
      instance_variables.each do |var|
        result[var] = instance_variable_get var
      end
      return result
    end

    def info
      return unless block_given?

      yield to_h
    end

    def <=>(other_item)
      min_price <=> other_item.min_price
    end
  end
end