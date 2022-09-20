class Vendor
    attr_reader :name,
                :inventory

    def initialize(name)
        @name = name
        @inventory = Hash.new(0)
    end

    def check_stock(item)
        inventory[item]
    end

    def stock(item, quantity)
        inventory[item] += quantity
    end

    def potential_revenue
        revenue = 0
        @inventory.each do |item_hash|
            total = 0
            item_hash.each do |item|
                if item.class == Item
                    total += item.price
                end
            end
            revenue += total * item_hash.last
        end
        revenue
    end
end