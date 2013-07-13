class MessageReceiveLocation < ActiveRecord::Base
  attr_accessible   :label, :location_x, :location_y,  :origin_source, :scale
  belongs_to :message_receive
	# def self.save(from_user_name,to_user_name,msg_type,msg_id,create_time,scale,location_x,location_y,label)
	#   	m = MessageReceiveLocation.new
	#   	m.label = label
	#   	m.from_user_name = from_user_name
	#   	m.to_user_name = to_user_name
	#   	m.msg_id = msg_id
	#   	m.msg_type = msg_type
	#   	m.create_time = create_time
	#   	m.scale = scale
	#   	m.location_x = location_x
	#   	m.location_y = location_y
	#   	m.save
 #  	end
end
