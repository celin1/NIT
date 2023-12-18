require_relative 'item_container'
require 'json'
require 'csv'

class Cart
  include ItemContainer
  attr_accessor :items

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
      f << ["name", "min_price", "max_price", "screen", "camera", "storage", "cpu", "ram", "battery", "body"]
      @items.each do |item|
        item.info do |data|
          f << [data[:name], data[:min_price], data[:max_price], data[:screen], data[:camera], data[:storage], data[:cpu], data[:ram], data[:battery], data[:body]]
        end
      end
    end
  end
end