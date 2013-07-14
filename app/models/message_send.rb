class MessageSend < ActiveRecord::Base
  attr_accessible :create_time, :from_user_name, :msg_type, :to_user_name, :func_flag
  has_one :message_send_music
  has_one :message_send_news
  has_one :message_send_text
  	def save_text(content)
		m_t = MessageSendText.new
		m_t.content = content
		
		self.message_send_text = m_t
	end


	def save_music(hq_music_url, music_url)
		m_m = MessageSendMusic.new
		m_m.hq_music_url = hq_music_url
		m_m.music_url = music_url

		self.message_send_music = m_m
	end

	def save_news(message_auto_reply_news)
		m_n = MessageSendNews.new
		m_n.message_send_news_articles = []

		message_auto_reply_news.message_auto_reply_news_articles.each do | article |
			m_n_a = MessageSendNewsArticle.new
			m_n_a.title = article.title
			m_n_a.description = article.description
			m_n_a.pic_url = request.protocol + request.host_with_port + article.pic_url
			m_n_a.url = article.url
			m_n.message_send_news_articles << m_n_a
		end

		self.message_send_news = m_n
	end

end
