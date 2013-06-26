class MessageKeyword < ActiveRecord::Base
  attr_accessible :content
  has_and_belongs_to_many :message_auto_reply_texts
  has_and_belongs_to_many :message_auto_reply_musics
  has_and_belongs_to_many :message_auto_reply_news
end
