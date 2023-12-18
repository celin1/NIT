require_relative 'item'
require_relative 'cart'
require_relative 'parser'
require_relative 'zipper'
require_relative 'user'

module MyApplacationSelin
  class MainApplication
    class << self
      def init
        return unless block_given?
  
        params = {file_path: "cart.txt", json_path: "cart.json", csv_path: "cart.csv", yaml_path: "cart.yaml",
                  zipfile_name: "archive.zip", file_ext: "rb", url: "https://ek.ua/ua/list/122/", 
                  parse_item: /Apple|Samsung/, validator: ->(array) { array.size < 10 },
                  user: User.new('selin.denys@chnu.edu.ua', 'odgb acxc ezys wtji')}
        yield params
        @@file_path = params[:file_path]
        @@json_path = params[:json_path]
        @@csv_path = params[:csv_path]
        @@yaml_path = params[:yaml_path]
        @@zipfile_name = params[:zipfile_name]
        @@file_ext = params[:file_ext]
        @@url = params[:url]
        @@parse_item = params[:parse_item]
        @@validator = params[:validator]
        @@user = params[:user]
      end

      def file_path
        @@file_path
      end
      def json_path
        @@json_path
      end
      def csv_path
        @@csv_path
      end
      def yaml_path
        @@yaml_path
      end
      def zipfile_name
        @@zipfile_name
      end
      def file_ext
        @@file_ext
      end
      def url
        @@url
      end
      def parse_item
        @@parse_item
      end
      def user
        @@user
      end
      def validator
        @@validator
      end
    end
  end
end