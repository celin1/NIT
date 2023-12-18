require 'mechanize'
require 'thread'

module MyApplacationSelin
  class Parser
    class << self
      def parse(url, regExp, validator)
        agent = Mechanize.new
        agent.log = Logger.new "mech.log"

        items = []
        doc = agent.get(url)

        while true
          data = doc.search('div.main-part-content table.model-short-block')

          mutex = Mutex.new
          work_q = Queue.new
          data.each {|data_piece| work_q.push data_piece}
          workers = (0...3).map do
              Thread.new do
                  begin
                      while !work_q.empty? && this_data = work_q.pop(true)
                        item = parse_item(this_data, regExp)
                        mutex.synchronize do
                          if !validator.call(items)
                            Thread.exit
                          end
                          unless item.nil?
                            items << item
                          end
                        end
                      end
                  rescue => e
                    puts e
                  end
              end
          end
          workers.map(&:join)

          if !validator.call(items)
            return items
          end
          
          doc = agent.page.link_with(:dom_id => 'pager_next')&.click
          if doc == nil
            break
          end
        end

        return items
      end
      def parse_item(data, regExp)
        name = data.search('td.model-short-info span.u')[0].text

        if !regExp.match?(name.freeze)
          return nil
        end

        price_data = data.search('td.model-hot-prices-td div.model-price-range span')
        min_price = price_data[0].text
        max_price = price_data.size > 1 ? price_data[1].text : price_data[0].text

        model_data = data.search('div.model-short-description div.m-s-f2 > div')

        params = {}

        model_data.each do |val|
          temp = val.text.split(':', 2)
          key = temp[0].tr("'\\- ", '_').to_sym
          value = temp[1]
          params[key] = value
        end

        item = Item.new(name, min_price, max_price, params)

        return item
      end
    end
  end
end