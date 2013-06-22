class MessageReceiveVoice < ActiveRecord::Base
  attr_accessible :create_time, :format, :from_user_name, :media_id, :msg_id, :msg_type, :recognition, :region_source, :to_user_name
end
