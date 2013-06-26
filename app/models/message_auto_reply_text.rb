class MessageAutoReplyText < ActiveRecord::Base
  attr_accessible :content
  has_and_belongs_to_many :message_keywords
end
