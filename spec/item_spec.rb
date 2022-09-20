require 'spec_helper'

RSpec.describe Item do
    let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
    let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

    it '1. exists' do
        expect(item1).to be_an_instance_of Item
    end

    it '2. has a name' do
        expect(item2.name).to eq 'Tomato'
    end

    it '3. has a price' do
        expect(item2.price).to eq 0.5
    end
end