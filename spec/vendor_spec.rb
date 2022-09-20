require './lib/item'
require './lib/vendor'
require 'rspec'

RSpec.describe Vendor do
    before(:each) do
        @vendor = Vendor.new("Rocky Mountain Fresh")
        @item1 = Item.new({name: 'Peach', price: "$0.75"})
        @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    end

    it '1. exists' do
        expect(@vendor).to be_an_instance_of Vendor
    end

    it '2. has a name' do
        expect(@vendor.name).to eq "Rocky Mountain Fresh"
    end

    it '3. has no inventory be default' do
        expect(@vendor.inventory).to eq({})
    end

    it '4. returns zero if item is not in stock' do
        expect(@vendor.check_stock(@item1)).to eq 0
    end

    it '5. can stock items and their quantities' do
        @vendor.stock(@item1, 30)
        expect(@vendor.inventory).to eq({@item1 => 30})
    end

    it '6. can check stock after inventory is added' do
        @vendor.stock(@item1, 30)
        expect(@vendor.check_stock(@item1)).to eq 30
    end

    it '7. keeps track of multiple items' do
        @vendor.stock(@item1, 30)
        @vendor.stock(@item1, 25)
        expect(@vendor.check_stock(@item1)).to eq 55
        @vendor.stock(@item2, 12)
        expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
    end
end