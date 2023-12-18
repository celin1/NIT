require_relative 'item'
require_relative 'cart'
require_relative 'parser'

class MainApplication
  class << self
    def init
      return unless block_given?

      params = {file_path: "cart.txt", json_path: "cart.json", csv_path: "cart.csv", 
                url: "https://ek.ua/ua/list/122/", regExp: /Apple|Samsung/, max_count: 10}
      yield params
      @@file_path = params[:file_path]
      @@json_path = params[:json_path]
      @@csv_path = params[:csv_path]
      @@url = params[:url]
      @@regExp = params[:regExp]
      @@max_count = params[:max_count]
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
    def url
      @@url
    end
    def regExp
      @@regExp
    end
    def max_count
      @@max_count
    end
  end
end