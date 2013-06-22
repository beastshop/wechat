class MessageReceiveImage < ActiveRecord::Base
  attr_accessible :create_time, :from_user_name, :msg_id, :msg_type, :origin_source, :pic_url, :to_user_name
end
