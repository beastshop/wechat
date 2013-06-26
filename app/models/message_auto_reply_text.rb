class MessageAutoReplyText < ActiveRecord::Base
  attr_accessible :content
  has_and_belongs_to_many :message_keywords, :join_table => "message_keywords_message_auto_reply_texts"
end
