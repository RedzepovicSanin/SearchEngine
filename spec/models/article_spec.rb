require 'rails_helper'

RSpec.describe Article, elasticsearch: true, type: :model do
  describe '#search' do
    before(:each) do
      Article.create(
        title: "DNC Nominates Kamala Harris in a Historic Selection for VP",
        text: "Kamala Harris accepted the Democratic vice-presidential nomination—becoming the first Black woman to hold that position—in a prime-time address that emphasized the historic nature of her candidacy while arguing Joe Biden is the uniting leader the country needs."
      )
      # refreshing indexes for each Article
      Article.__elasticsearch__.refresh_index!
    end
    it "should index title" do
      expect(Article.search("Kamala").records.length).to eq(1)
    end
    it "should index text" do
      expect(Article.search("Democratic").records.length).to eq(1)
    end
    it "should apply stemming to title" do
      expect(Article.search("Historics").records.length).to eq(1)
    end
    it "should apply stemming to text" do
      expect(Article.search("vice-presidentia").records.length).to eq(1)
    end
  end
end
