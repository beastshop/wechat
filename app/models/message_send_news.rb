class MessageSendNews < ActiveRecord::Base
  attr_accessible :article_count
  has_many :message_send_news_articles
  belongs_to :message_send
  default_scope order: 'id desc'
end
