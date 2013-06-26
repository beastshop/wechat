class MessageAutoReplyNewsArticle < ActiveRecord::Base
  attr_accessible :description, :message_auto_reply_news_id, :pic_url, :title, :url
  belongs_to :message_auto_reply_news
end
