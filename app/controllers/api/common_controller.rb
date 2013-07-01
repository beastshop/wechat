# encoding: utf-8
class Api::CommonController < Api::ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source

	def test
		render :text => params[:echostr]
	end

	def echo
		p params[:xml][:MsgType]
		@message = MessageSendText.new
		@message.to_user_name = params[:xml][:FromUserName]
		@message.from_user_name = params[:xml][:ToUserName]
		@message.create_time = Time.now

		main_tree = "1.查询订单 2.录入祝福"

		user = MagentoCustomer.where(:wechat_user_open_id => @message.from_user_name).first

		
		p user
		case params[:xml][:MsgType]
		when "text"
			msg_text = params[:xml][:Content]
			p @message
			case msg_text
			when "0"
				@message.content = main_tree
			when "1"
				unless user.nil?
					orders = TheBeast::Order.get_list(user.user_id).where(:status => "pending")
					orders.each do | order |
						@message.content +=  "订单号: " + order.order_code + "<br/>" + "地址: " + order.address + "<br/>" + "备注: " + order.note + "<br/>"
					end
				else
					@message.content = "您还未绑定TheBeast账号，请<a href='http://ds.12doo.com/the_beast/sessions/new'>绑定</a>"
				end
			when "2"
				@message.content = "请输入祝福的文字或图片,输入 0  退出录入祝福"
			else
				unless user.nil?	
					card = Card.new
					card.content = msg_text
					card.order_no = TheBeast::Order.get_list(user.user_id).where(:status => "pending").first.order_no
				end

				@message.content = "无法理解您的输入，请重新按菜单输入 <br/>" + main_tree
			end
			
			render :xml, :template => 'api/message_text'
			##-------------------------------   关键字匹配代码 Don't Remove -----------------------------------------------------------------------
			# @mkw = MessageKeyword.where("locate(content,'#{msg_text}')>0").first

			# if !@mkw.nil?
			# 	if @mkw.message_auto_reply_texts.size > 0
			# 		@message.content = @mkw.message_auto_reply_texts.first.content
			# 		render :xml, :template => 'api/message_text'
			# 	elsif @mkw.message_auto_reply_musics.size > 0
			# 		@message = MessageSendMusic.new
			# 		@message.to_user_name = params[:xml][:FromUserName]
			# 		@message.from_user_name = params[:xml][:ToUserName]
			# 		@message.create_time = Time.now
			# 		@message.music_url = request.protocol + request.host_with_port + @mkw.message_auto_reply_musics.first.music_url.to_s
			# 		@message.hq_music_url = request.protocol + request.host_with_port + @mkw.message_auto_reply_musics.first.hq_music_url.to_s
			# 		p @message
			# 		render :xml, :template => 'api/message_music'
			# 	elsif @mkw.message_auto_reply_news.size > 0
			# 		@message = MessageSendNews.new
			# 		@message.to_user_name = params[:xml][:FromUserName]
			# 		@message.from_user_name = params[:xml][:ToUserName]
			# 		@message.create_time = Time.now
			# 		@mkw.message_auto_reply_news.first.message_auto_reply_news_articles.each do | article |
			# 			news_article = MessageSendNewsArticle.new
			# 			news_article.title = article.title
			# 			news_article.description = article.description
			# 			news_article.pic_url = request.protocol + request.host_with_port + article.pic_url.to_s
			# 			news_article.url = article.url
			# 			@message.message_send_news_articles << news_article
			# 		end
			# 		p @message
			# 		render :xml, :template => 'api/message_news'
			# 	end
			# else
			# 	render :xml, :template => 'api/message_text'
			# end
			##-------------------------------   关键字匹配代码 Don't Remove -----------------------------------------------------------------------


		when "image"
			card_image = CardImage.new
			card_image.picture_file_name = params[:xml][:PicUrl]
			card_image.order_no = TheBeast::Order.get_list(user.user_id).where(:status => "pending").first.order_no

			@message.content = "我们收到了您的图片信息,请继续输入文字或图片， 按 0 退出录入祝福"
			render :xml, :template => 'api/message_text'
		when "location"
			@message.content = "我们收到了您的位置信息"
			render :xml, :template => 'api/message_text'
		when "voice"
			@message.content = "我们收到了您的留言信息"
			render :xml, :template => 'api/message_text'
		when "event"
			case params[:xml][:Event]
			when "subscribe"
				@message.content = '感谢您的关注' + main_tree
			when "unsubscribe"
				@message.content = '感谢您再次关注' + main_tree
			end
			render :xml, :template => 'api/message_text'
		end
		p @message
	end

end
