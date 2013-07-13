class MessageReceiveVoice < ActiveRecord::Base
  attr_accessible  :format,  :media_id,  :recognition, :region_source
  belongs_to :message_receive

  # def self.save(from_user_name,to_user_name,msg_type,msg_id,create_time,media_id,format,recognition)
  # 	m = MessageReceiveVoice.new
  # 	m.format = format
  # 	m.from_user_name = from_user_name
  # 	m.to_user_name = to_user_name
  # 	m.msg_id = msg_id
  # 	m.msg_type = msg_type
  # 	m.create_time = create_time
  # 	m.media_id = media_id
  # 	m.recognition = recognition
  # 	m.save
  # end
end
