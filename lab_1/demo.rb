require_relative 'main_application'

MainApplication.init do |par|
  par[:file_path] = "cart.txt"
  par[:json_path] = "cart.json"
  par[:csv_path] = "cart.csv"
  par[:url] = "https://ek.ua/ua/list/122/"
  par[:regExp] = /Apple|Samsung/
  par[:max_count] = 10
end

items = Parser.parse(MainApplication.url, MainApplication.regExp, MainApplication.max_count)

cart = Cart.new

cart.add_item(items[0])
cart.add_item(items[1])

puts cart.items

(2..9).each{|n| cart.add_item(items[n])}

cart.save_to_file(MainApplication.file_path)

cart.remove_item(items[1])

cart.save_to_json(MainApplication.json_path)
cart.save_to_csv(MainApplication.csv_path)

cart.items.each do |item|
  item.info do |data|
    puts data[:name]
  end
end

cart.delete_items

cart.add_item(items[1])

cart.test_method