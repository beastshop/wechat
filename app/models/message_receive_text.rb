class MessageReceiveText < ActiveRecord::Base
  attr_accessible :content, :create_time, :from_user_name, :msg_id, :msg_type, :origin_source, :to_user_name
  default_scope order: 'id desc' 
  def self.save(from_user_name,to_user_name,msg_type,msg_id,create_time,content)
  	m = MessageReceiveText.new
  	m.content = content
  	m.from_user_name = from_user_name
  	m.to_user_name = to_user_name
  	m.msg_id = msg_id
  	m.msg_type = msg_type
  	m.create_time = create_time

  	m.save
  end
end
