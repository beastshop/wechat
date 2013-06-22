class MessageReceiveText < ActiveRecord::Base
  attr_accessible :content, :create_time, :from_user_name, :msg_id, :msg_type, :origin_source, :to_user_name
end
