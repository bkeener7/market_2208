require 'spec_helper'

RSpec.describe Market do
        let(:market) {Market.new("South Pearl Street Farmers Market")}
        let(:vendor1) {Vendor.new("Rocky Mountain Fresh")}
        let(:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
        let(:vendor3) {Vendor.new("Palisade Peach Shack")}
        let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
        let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
        let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
        let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}
    before(:each) do
        vendor1.stock(item1, 35)
        vendor1.stock(item2, 7)
        vendor2.stock(item4, 50)
        vendor2.stock(item3, 25)
        vendor3.stock(item1, 65)
    end

    it '1. exists' do
        expect(market).to be_an_instance_of Market
    end

    it '2. has a name' do
        expect(market.name).to eq "South Pearl Street Farmers Market"
    end

    it '3. has no vendors by default' do
        expect(market.vendors).to eq([])
    end

    describe '#add vendors' do
        before(:each) do
            market.add_vendor(vendor1)
            market.add_vendor(vendor2)
            market.add_vendor(vendor3)
        end

        it '4. can add vendors that can stock items' do        
            expect(market.vendors).to eq([vendor1, vendor2, vendor3])
        end

        it '5. can display vendor names' do      
            expect(market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
        end

        it '6. can find vendors that sell an item' do       
            expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
            expect(market.vendors_that_sell(item4)).to eq([vendor2])
        end

    

        it '7. can list total inventory' do 
            vendor3.stock(item3, 10)
            expected_hash = {
            item1 => {
                    quantity: 100,
                    vendors: [vendor1, vendor3]
                }, 
                item2 => {
                    quantity: 7,
                    vendors: [vendor1]
                },
                item4 => {
                    quantity: 50,
                    vendors: [vendor2]
                },
                item3 => {
                    quantity: 35,
                    vendors: [vendor2, vendor3]
                }
            }
            expect(market.total_inventory).to eq(expected_hash)
        end

        it '8. can return overstocked items' do
            vendor3.stock(item3, 10)
            expect(market.overstocked_items).to eq([item1])
        end

        it '9. can sort item inventory' do
            vendor3.stock(item3, 10)
            expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
        end

        it '10. can return a date for the market' do
            allow(Date).to receive(:today).and_return(Date.new(2022,9,20))
            expect(market.date).to eq "20/09/2022"
        end

        it '11. can sell items' do
            item5 = Item.new({name: 'Onion', price: '$0.25'})
            expect(market.sell(item1, 200)).to eq false
            expect(market.sell(item5, 1)).to eq false
            expect(market.sell(item4, 5)).to eq true
            expect(vendor2.check_stock(item4)).to eq 45
            expect(market.sell(item1, 40)).to eq true
            expect(vendor1.check_stock(item1)).to eq 0
            expect(vendor3.check_stock(item1)).to eq 60
        end
    end
end