class MessageReceive < ActiveRecord::Base
	attr_accessible :create_time, :from_user_name, :msg_id, :msg_type, :to_user_name
	has_one :message_receive_event
	has_one :message_receive_image
	has_one :message_receive_link
	has_one :message_receive_location
	has_one :message_receive_voice
	has_one :message_receive_text
	default_scope order: 'id desc'



	def save_text(content)
		m_t = MessageReceiveText.new
		m_t.content = content
		# m_t.origin_source = origin_source
		self.message_receive_text = m_t
	end

	def save_image(pic_url)
		m_i = MessageReceiveImage.new
		m_i.pic_url = pic_url
		# m_i.origin_source = origin_source
		self.message_receive_image = m_i
	end

	def save_location(scale, location_x, location_y, label)
		m_l = MessageReceiveLocation.new
		m_l.label = label
		m_l.location_x = location_x
		m_l.location_y = location_y
		# m_l.origin_source = m_l.origin_source
		m_l.scale = scale
		self.message_receive_location = m_l
	end

	def save_event(event, event_key)
		m_e = MessageReceiveEvent.new
		m_e.event = event
		m_e.event_key = event_key
		# m_e.origin_source = origin_source
		self.message_receive_event = m_e
	end

	def save_voice(media_id, format, recognition)
		m_v = MessageReceiveVoice.new
		m_v.format = format
		m_v.media_id = media_id
		m_v.recognition = recognition
		# m_v.region_source = region_source
		self.message_receive_voice = m_v
	end

	def save_link(description, title, url)
		m_l = MessageReceiveLink.new
		m_l.description = description
		# m_l.origin_source = origin_source
		m_l.title = title
		self.message_receive_link = m_l
	end


end
