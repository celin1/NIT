require 'nokogiri'
require 'open-uri'

class Parser
  class << self
    def parse(url, regExp, max_count)
      items = []
      (0..9).each do |n|
        doc = n==0 ? Nokogiri::HTML(URI.open(url)) : Nokogiri::HTML(URI.open("#{url}/#{n.to_s}"))
        data = doc.css('div.main-part-content table.model-short-block')

        data.each do |html|
          item = parse_item(html, regExp)
          if item != nil
            items << item
          end

          if items.size == max_count
            return items
          end

        end
      end

      return items
    end
    def parse_item(data, regExp)
      name = data.css('td.model-short-info span.u')[0].text

      if !regExp.match?(name.freeze)
        return nil
      end

      price_data = data.css('td.model-hot-prices-td div.model-price-range span')
      min_price = price_data[0].text
      max_price = price_data.size > 1 ? price_data[1].text : price_data[0].text

      model_data = data.css('div.model-short-description div.m-s-f2 > div')
      screen = model_data[0].text.split(':', 2)[1]
      camera = model_data[1].text.split(':', 2)[1]
      storage = model_data[2].text.split(':', 2)[1]
      cpu = model_data[3].text.split(':', 2)[1]
      ram =  model_data[4].text.split(':', 2)[1]
      battery = model_data[5].text.split(':', 2)[1]
      body = model_data[6].text.split(':', 2)[1]

      return Item.new(name, min_price, max_price, screen, camera, storage, cpu, ram, battery, body)
    end
  end
end