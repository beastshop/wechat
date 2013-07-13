class MessageSendNewsArticle < ActiveRecord::Base
  attr_accessible :description, :message_send_news_id, :pic_url, :title, :url
  belongs_to :message_send_news
  default_scope order: 'id desc' 
end
