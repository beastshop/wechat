class MessageSendText < ActiveRecord::Base
  attr_accessible :content, :create_time, :from_user_name, :func_flag, :msg_type, :to_user_name


end
