class MessageSendMusic < ActiveRecord::Base
  attr_accessible   :hq_music_url, :music_url, :title, :description
  belongs_to :message_send
  default_scope order: 'id desc'
end
