class MessageReceiveEvent < ActiveRecord::Base
  attr_accessible :create_time, :event, :event_key, :from_user_name, :msg_type, :origin_source, :to_user_name
end
