class MessageAutoReplyNews < ActiveRecord::Base
  attr_accessible :article_count, :content
  has_and_belongs_to_many :message_keywords
end
