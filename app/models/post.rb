class Post
  include Mongoid::Document
  field :title, type: String
  field :text, type: String
  field :minute, type: String
  field :hour, type: String
  field :date, type: String
  field :coordinate, type: Array
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  embeds_one :location
  embeds_one :streetview
  embeds_many :comments
  # embeds_many :users, :store_as => "participants"
  belongs_to :hostuser, :class_name => "User", :inverse_of => nil
  # belongs_to :host, :class_name => "User", :inverse_of => :host
  # belongs_to :participant, :class_name => "User", :inverse_of => :participant

  def host
      @host = self.hostuser
  end
end
