class MessageReceiveEvent < ActiveRecord::Base
  attr_accessible :event, :event_key,  :origin_source
  belongs_to :message_receive

  # def self.save(from_user_name,to_user_name,msg_type,msg_id,create_time,event,event_key)
  # 	m = MessageReceiveEvent.new
  # 	m.event = event
  # 	m.event_key = event_key
  # 	m.from_user_name = from_user_name
  # 	m.to_user_name = to_user_name
  # 	m.msg_id = msg_id
  # 	m.msg_type = msg_type
  # 	m.create_time = create_time
  	
  # 	m.save
  # end
end
