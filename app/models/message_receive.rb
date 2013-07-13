class MessageReceive < ActiveRecord::Base
	attr_accessible :ceate_time, :from_user_name, :msg_id, :msg_type, :to_user_name
	has_one :message_receive_event, :message_receive_imag, :message_receive_link, :message_receive_location, :message_receive_text, :message_receive_voice

	def save_text(content)
		m_t = MessageReceiveText.new
		m_t.content = content
		# m_t.origin_source = origin_source
		m_t.message_receive = self
	end

	def save_image(pic_url)
		m_i = MessageReceiveImage.new
		m_i.pic_url = pic_url
		# m_i.origin_source = origin_source
		m_i.message_receive = self
	end

	def save_location(scale, location_x, location_y, label)
		m_l = MessageReceiveLocation.new
		m_l.label = label
		m_l.location_x = location_x
		m_l.location_y = location_y
		# m_l.origin_source = m_l.origin_source
		m_l.scale = scale
		m_l.message_receive = self
	end

	def save_event(event, event_key)
		m_e = MessageReceiveEvent.new
		m_e.event = event
		m_e.event_key = event_key
		# m_e.origin_source = origin_source
		m_e.message_receive = self
	end

	def save_voice(media_id, format, recognition)
		m_v = MessageReceiveVoice.new
		m_v.format = format
		m_v.media_id = media_id
		m_v.recognition = recognition
		# m_v.region_source = region_source
		m_v.message_receive = self
	end

	def save_link(description, title, url)
		m_l = MessageReceiveLink.new
		m_l.description = description
		# m_l.origin_source = origin_source
		m_l.title = title
		m_l.url = url
	end

end
