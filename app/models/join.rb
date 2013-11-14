class Join
  include Mongoid::Document
  field :user_id, type: String
  field :user_name, type: String
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  embedded_in :post, :inverse_of => :joins
end
