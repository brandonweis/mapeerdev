class Location
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :approx_address, type: String
  field :lat, type: Float
  field :lng, type: Float
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  embedded_in :post
end
