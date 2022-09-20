class Market
    attr_reader :name,
                :vendors

    def initialize(name)
        @name = name
        @vendors = []
    end

    def add_vendor(vendor)
        vendors.push(vendor)
    end

    def vendor_names
        @vendors.map(&:name)
    end

    def vendors_that_sell(item)
        @vendors.select { |vendor| vendor.check_stock(item) > 0 }
    end

    def inventory_list
        @vendors.map { |vendor| vendor.inventory.keys }.flatten.uniq
    end

    def total_item(item)
        quantity_avail = 0
        @vendors.each { |vendor| quantity_avail += vendor.check_stock(item) }
        quantity_avail
    end    

    def total_inventory
        inventory_hash = Hash.new
        inventory_list.each { |item| inventory_hash[item] = {quantity: total_item(item), vendors: vendors_that_sell(item)}}
        inventory_hash
    end

    def overstocked_items
        total_inventory.select { |item, details| details[:quantity] > 50 && details[:vendors].count >= 2 }.keys
    end

    def sorted_item_list
        inventory_list.map { |item, details| item.name }.sort
    end

    def date
        Date.today.strftime("%d/%m/%Y").to_s
    end

    def sell(item, quantity)
        return false if sorted_item_list.none?(item.name)
        return false if total_inventory[item][:quantity] < quantity

        total_inventory[item][:vendors].each do |vendor|
            if vendor.inventory[item] < quantity
                quantity -= vendor.inventory[item]
                vendor.inventory[item] = 0
           else
                vendor.inventory[item] -= quantity
                break
           end
        end
        true
    end
end