require_relative 'engine'

MyApplacationSelin::MainApplication::init do |par|
  par[:file_path] = "cart.txt"
  par[:json_path] = "cart.json"
  par[:csv_path] = "cart.csv"
  par[:yaml_path] = "cart.yaml"
  par[:zipfile_name] = "archive.zip"
  par[:file_ext] = "rb"
  par[:url] = "https://ek.ua/ua/list/122/"
  par[:parse_item] = /Apple|Samsung/
  par[:validator] = ->(array) { array.size < 10 }
  par[:user] = MyApplacationSelin::User.new('selin.denys@chnu.edu.ua', 'odgb acxc ezys wtji')
end

MyApplacationSelin::Engine::process