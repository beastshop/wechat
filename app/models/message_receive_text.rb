class MessageReceiveText < ActiveRecord::Base
  attr_accessible :content,  :origin_source
  belongs_to :message_receive
  default_scope order: 'id desc' 
end
