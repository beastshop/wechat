class MessageSend < ActiveRecord::Base
  attr_accessible :create_time, :from_user_name, :msg_type, :to_user_name, :func_flag
  has_one :message_send_music
  has_one :message_send_news
  has_one :message_send_text
  default_scope order: 'id desc'

  	def save_text(content)
		m_t = MessageSendText.new
		m_t.content = content
		self.msg_type = "text"
		self.message_send_text = m_t
	end


	def save_music(hq_music_url, music_url, title, description)
		m_m = MessageSendMusic.new
		m_m.title = title
		m_m.description = description
		m_m.hq_music_url = hq_music_url
		m_m.music_url = music_url
		self.msg_type = "music"
		self.message_send_music = m_m
	end

	def save_news(message_auto_reply_news,host)
		m_n = MessageSendNews.new
		m_n.message_send_news_articles = []

		message_auto_reply_news.message_auto_reply_news_articles.each do | article |
			m_n_a = MessageSendNewsArticle.new
			m_n_a.title = article.title
			m_n_a.description = article.description
			m_n_a.pic_url = host + article.pic_url.to_s 
			m_n_a.url = article.url
			m_n.message_send_news_articles << m_n_a
		end
		self.msg_type = "news"
		self.message_send_news = m_n
	end

end
