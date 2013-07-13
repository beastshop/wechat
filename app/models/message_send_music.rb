class MessageSendMusic < ActiveRecord::Base
  attr_accessible   :hq_music_url, :music_url
  belongs_to :message_send
end
