class MessageAutoReplyMusic < ActiveRecord::Base
  attr_accessible :hq_music_url, :music_url
  has_and_belongs_to_many :message_keywords, :join_table => "message_keywords_message_auto_reply_musics"
end
