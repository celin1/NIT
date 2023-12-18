require_relative 'main_application'
require 'thread'

module MyApplacationSelin
  class Engine
    class << self
      def process
        sem = Queue.new

        parser_thread = Thread.new do
          items = MyApplacationSelin::Parser.parse(MyApplacationSelin::MainApplication.url, 
                                                  MyApplacationSelin::MainApplication.parse_item, 
                                                  MyApplacationSelin::MainApplication.validator)

          cart = MyApplacationSelin::Cart.new

          items.each{|item| cart.add_item(item)}

          cart.each{|item| puts item}

          cart.save_to_file(MyApplacationSelin::MainApplication.file_path)

          cart.remove_item(items[1])

          cart.save_to_json(MyApplacationSelin::MainApplication.json_path)
          cart.save_to_csv(MyApplacationSelin::MainApplication.csv_path)
          cart.save_to_yaml(MyApplacationSelin::MainApplication.yaml_path)

          puts "done parser"
        end

        zip_thread = Thread.new do
          MyApplacationSelin::Zipper.zip(MyApplacationSelin::MainApplication.zipfile_name,
                                          MyApplacationSelin::MainApplication.file_ext)
          sem.enq :go
          puts "done zip"
        end

        message_thread = Thread.new do
          sem.deq
          MyApplacationSelin::MainApplication.user.send_message('selin.denys0@gmail.com', 'Lab №2', '', 
                                {title: "lab_2.zip", file_path: MyApplacationSelin::MainApplication.zipfile_name }) # o.matviy@chnu.edu.ua
          puts "done message"
        end

        parser_thread.join
        zip_thread.join
        message_thread.join
      end
    end
  end
end