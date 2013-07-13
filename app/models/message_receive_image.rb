class MessageReceiveImage < ActiveRecord::Base
  attr_accessible  :origin_source, :pic_url
  belongs_to :message_receive
  default_scope order: 'id desc' 
end
