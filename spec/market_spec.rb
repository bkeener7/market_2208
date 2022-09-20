require './lib/item'
require './lib/vendor'
require './lib/market'
require 'rspec'

RSpec.describe Market do
    before(:each) do
        @market = Market.new("South Pearl Street Farmers Market")
        @vendor1 = Vendor.new("Rocky Mountain Fresh")
        @vendor2 = Vendor.new("Ba-Nom-a-Nom")
        @vendor3 = Vendor.new("Palisade Peach Shack")
        @item1 = Item.new({name: 'Peach', price: "$0.75"})
        @item2 = Item.new({name: 'Tomato', price: '$0.50'})
        @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
        @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
        @vendor1.stock(@item1, 35)
        @vendor1.stock(@item2, 7)
        @vendor2.stock(@item4, 50)
        @vendor2.stock(@item3, 25)
        @vendor3.stock(@item1, 65)
        @vendor3.stock(@item3, 10)
    end

    it '1. exists' do
        expect(@market).to be_an_instance_of Market
    end

    it '2. has a name' do
        expect(@market.name).to eq "South Pearl Street Farmers Market"
    end

    it '3. has no vendors by default' do
        expect(@market.vendors).to eq([])
    end

    it '4. can add vendors that can stock items' do
        @market.add_vendor(@vendor1)
        @market.add_vendor(@vendor2)
        @market.add_vendor(@vendor3)
        expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it '5. can display vendor names' do
        @market.add_vendor(@vendor1)
        @market.add_vendor(@vendor2)
        @market.add_vendor(@vendor3)
        expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it '6. can find vendors that sell an item' do
        @market.add_vendor(@vendor1)
        @market.add_vendor(@vendor2)
        @market.add_vendor(@vendor3)
        expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
        expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end

    # it '7. can list total inventory' do
    #     @market.add_vendor(@vendor1)
    #     @market.add_vendor(@vendor2)
    #     @market.add_vendor(@vendor3)

    #     expect(@market.total_inventory).to eq()
    # end

end