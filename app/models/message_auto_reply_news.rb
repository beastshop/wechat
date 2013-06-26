class MessageAutoReplyNews < ActiveRecord::Base
  attr_accessible :article_count, :content
  has_and_belongs_to_many :message_keywords
  has_many :message_auto_reply_news_articles
end
