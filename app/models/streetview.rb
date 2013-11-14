class Streetview
  include Mongoid::Document

  # fields
  #field :size_x, type: Integer #, default 300
  #field :size_y, type: Integer #, default 200
  #field :sensor, type: Boolean #, default false
  field :heading, type: Float #compas heading direction
  #field :fov, type: Float #, default 90 #horizontal angle
  field :pitch, type: Float #, default 0 #vertical angle
  #field :key, type: String #, default ""
  field :lat, type: Float
  field :lng, type: Float
  field :zoom, type: Float
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  # validation
  # validates_exclusion_of :heading, in: 0..360, message: 'Accepted values are from 0 to 360'
  # validates_exclusion_of :fov, in: 0..360, message: 'Accepted values are from 0 to 360'

  # embedded attribute
  embedded_in :post
end
