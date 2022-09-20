require 'spec_helper'

RSpec.describe Vendor do
        let(:vendor) {Vendor.new("Rocky Mountain Fresh")}
        let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
        let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

    it '1. exists' do
        expect(vendor).to be_an_instance_of Vendor
    end

    it '2. has a name' do
        expect(vendor.name).to eq "Rocky Mountain Fresh"
    end

    it '3. has no inventory be default' do
        expect(vendor.inventory).to eq({})
    end

    it '4. returns zero if item is not in stock' do
        expect(vendor.check_stock(item1)).to eq 0
    end

    it '5. can stock items and their quantities' do
        vendor.stock(item1, 30)
        expect(vendor.inventory).to eq({item1 => 30})
    end

    it '6. can check stock after inventory is added' do
        vendor.stock(item1, 30)
        expect(vendor.check_stock(item1)).to eq 30
    end

    it '7. keeps track of multiple items' do
        vendor.stock(item1, 30)
        vendor.stock(item1, 25)
        expect(vendor.check_stock(item1)).to eq 55
        vendor.stock(item2, 12)
        expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
    end

    it '8. can determine potential revenue' do
        vendor1 = Vendor.new("Rocky Mountain Fresh")
        vendor2 = Vendor.new("Ba-Nom-a-Nom")
        vendor3 = Vendor.new("Palisade Peach Shack")
        item1 = Item.new({name: 'Peach', price: "$0.75"})
        item2 = Item.new({name: 'Tomato', price: '$0.50'})
        item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
        item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
        vendor1.stock(item1, 35)
        vendor1.stock(item2, 7)
        vendor2.stock(item4, 50)
        vendor2.stock(item3, 25)
        vendor3.stock(item1, 65)      

        expect(vendor1.potential_revenue).to eq 29.75
        expect(vendor2.potential_revenue).to eq 345.00
        expect(vendor3.potential_revenue).to eq 48.75
    end
end