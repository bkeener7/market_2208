class Item
    attr_reader :item_info,
                :price

    def initialize(item_hash)
        @item_info = item_hash
    end

    def name 
        item_info[:name]
    end

    def price
        item_info[:price][1..-1].to_f
    end
end