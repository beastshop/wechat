class MessageSendMusic < ActiveRecord::Base
  attr_accessible :create_time, :from_user_name, :func_flag, :hq_music_url, :msg_type, :music_url, :to_user_name
  default_scope order: 'id desc' 

end
