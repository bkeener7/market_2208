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
        @vendors.map { |vendor| vendor.name }
    end

    def vendors_that_sell(item)
        @vendors.select { |vendor| vendor if vendor.check_stock(item) != 0 }
    end

#     def total_inventory
#         item_total = Hash.new
#         @vendors.each do |vendor|
#             vendor.inventory.each do |item|
#                 require 'pry'; binding.pry
#                 item_total[item.first] = (item, item_total)
#             end
#         end
        
#         item_total           
#     end
end
