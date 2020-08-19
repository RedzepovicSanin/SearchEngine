require 'rails_helper'

RSpec.describe Product, elasticsearch: true, type: :model do
  describe '#search' do
    before(:each) do
      Product.create(
        name: "Joystick PS4",
        price: "69.99",
        overview: "Tool used to play video games!",
        quantity: 4
      )
      # refreshing indexes for each product
      Product.__elasticsearch__.refresh_index!
    end
    it "should index name" do
      expect(Product.search("PS4").records.length).to eq(1)
    end
    it "should index overview" do
      expect(Product.search("used").records.length).to eq(1)
    end
    it "should index price" do
      expect(Product.search("69.99").records.length).to eq(1)
    end
    it "should not index quantity" do
      expect(Product.search("4").records.length).to eq(0)
    end
    it "should apply stemming to name" do
      expect(Product.search("Joysticks").records.length).to eq(1)
    end
    it "should apply stemming to overview" do
      expect(Product.search("plays").records.length).to eq(1)
    end
  end
end
