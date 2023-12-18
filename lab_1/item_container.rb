module ItemContainer
  module InstanceMethods
    def add_item(item)
      @items << item
    end
    def remove_item(item)
      @items -= [item]
    end
    def delete_items
      @items = []
    end
    def method_missing(method, *args)
      puts "No method #{method}"
      puts "Item list:"
      show_all_items
    end
    def show_all_items
      @items.each{|item| puts item}
    end
  end
  module ClassMethods
  end
  def self.included(class_instance)
    class_instance.include InstanceMethods
    class_instance.extend ClassMethods
  end
end