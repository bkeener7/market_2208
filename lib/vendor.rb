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
            item_hash.each { |item| total += item.price if item.class == Item }
            revenue += total * item_hash.last
        end
        revenue
    end
end