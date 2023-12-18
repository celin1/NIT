require_relative 'item_container'
require 'json'
require 'csv'
require 'yaml'

module MyApplacationSelin
  class Cart
    include ItemContainer
    attr_accessor :items

    include Enumerable

    def each
      return unless block_given?
      items.each do |item|
          yield item
      end
    end

    def initialize
      @items = []
    end
    def save_to_file(file_name)
      File.open(file_name, 'w') do |f|
        @items.each do |item|
          f.puts item
        end
      end
    end
    def save_to_json(file_name)
      File.open(file_name, 'w') do |f|
        hash = @items.map{|item| item.to_h}
        f.write(JSON.pretty_generate(hash))
      end
    end
    def save_to_csv(file_name)
      CSV.open(file_name, 'w') do |f|
        if items.empty?
          return
        end
        first_item = items.first
        names = []
        first_item.instance_variables.each do |var|
          names << var.to_s
        end
        f << names
        @items.each do |item|
          data = []
          item.instance_variables.each do |var|
            data << item.instance_variable_get(var)
          end
          f << data
        end
      end
    end
    def save_to_yaml(file_name)
      File.open(file_name, 'w') do |f|
        hash = @items.map{|item| item.to_h}
        f.write hash.to_yaml
      end
    end
  end
end