class MessageSendText < ActiveRecord::Base
  attr_accessible :content
  belongs_to :message_send
  default_scope order: 'id desc'
end
