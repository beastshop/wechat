class MessageReceiveLink < ActiveRecord::Base
  attr_accessible :create_time, :description, :from_user_name, :msg_id, :msg_type, :origin_source, :title, :to_user_name, :url
end
