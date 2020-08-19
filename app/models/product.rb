require 'elasticsearch/model'

class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # setting manual indexes
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'english'
      indexes :price, analyzer: 'english'
      indexes :overview, analyzer: 'english'
    end
  end
end
