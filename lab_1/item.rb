class Item
  def initialize(name, min_price, max_price, screen, camera, storage, cpu, ram, battery, body)
    @name, @min_price, @max_price, @screen, @camera, @storage, @cpu, @ram, @battery, @body = name, min_price, max_price, screen, camera, storage, cpu, ram, battery, body
  end
  attr_accessor :name, :min_price, :max_price, :screen, :camera, :storage, :cpu, :ram, :battery, :body

  def to_s
    "Item: name: #{@name}, price: #{@min_price}-#{@max_price}, screen: #{@screen}, camera: #{@camera}, storage: #{@storage}, cpu: #{@cpu}, ram: #{@ram}, battery: #{@battery}, body: #{@body}"
  end

  def to_h
    {name: @name, min_price: @min_price, max_price: @max_price, screen: @screen, camera: @camera, storage: @storage, cpu: @cpu, ram: @ram, battery: @battery, body: @body}
  end

  def info
    return unless block_given?

    yield to_h
  end
end