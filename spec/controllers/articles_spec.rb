require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  # searching for a Article with specific title
  describe "GET /articles?search=" do
    let(:title) { "article-title"}
    let(:url) { "/articles?search=#{title}"}

    it "calls Article.search with correct parameters" do
      expect(Article).to receive(:search).with(title)
      get url
    end
    
    it "returns the output of Article.search" do
      allow(Article).to receive(:search).and_return({})
      get url
      expect(response.body).to eq({}.to_json)
    end
        
    it 'returns a success status' do
      allow(Article).to receive(:search).with(title)
      get url
      expect(response).to be_successful
    end
  end
end