class MessageSendText < ActiveRecord::Base
  attr_accessible :content
  belongs_to :message_send
end
