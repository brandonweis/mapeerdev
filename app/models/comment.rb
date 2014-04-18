class Comment
  include Mongoid::Document
  field :text, type: String
  field :post_id, type: String
  field :user_id, type: String
  field :user_name, type: String
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  embedded_in :post
  embeds_many :conversations
end
