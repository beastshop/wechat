class MessageSendNews < ActiveRecord::Base
  attr_accessible :article_count, :create_time, :from_user_name, :func_flag, :msg_type, :to_user_name
end
