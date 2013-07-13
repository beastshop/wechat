class MessageReceiveEvent < ActiveRecord::Base
  attr_accessible :event, :event_key,  :origin_source
  belongs_to :message_receive
  default_scope order: 'id desc' 
end
