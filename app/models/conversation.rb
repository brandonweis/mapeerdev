class Conversation
  include Mongoid::Document
  field :text, type: String
  field :status, type: String
  field :user_id, type: String
  field :user_name, type: String
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  embedded_in :comment
end
