class Joinedpost
  include Mongoid::Document
  field :post_id, type: String

  embedded_in :user, :inverse_of => :joinedposts
end
