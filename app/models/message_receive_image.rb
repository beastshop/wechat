class MessageReceiveImage < ActiveRecord::Base
  attr_accessible :create_time, :from_user_name, :msg_id, :msg_type, :origin_source, :pic_url, :to_user_name


  def self.save(from_user_name,to_user_name,msg_type,msg_id,create_time,pic_url)
  	m = MessageReceiveImage.new
  	m.pic_url = pic_url
  	m.from_user_name = from_user_name
  	m.to_user_name = to_user_name
  	m.msg_id = msg_id
  	m.msg_type = msg_type
  	m.create_time = create_time
  	
  	m.save
  end
end
