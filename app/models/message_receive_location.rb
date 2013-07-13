class MessageReceiveLocation < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible   :label, :location_x, :location_y,  :origin_source, :scale
  belongs_to :message_receive
   default_scope order: 'id desc' 
end
