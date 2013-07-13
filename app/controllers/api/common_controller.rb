# encoding: utf-8
class Api::CommonController < Api::ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source
	layout false
	def test
		render :text => params[:echostr]
	end

	def echo
		p params[:xml][:MsgType]
		@message = MessageSendText.new
		@message.to_user_name = params[:xml][:FromUserName]
		@message.from_user_name = params[:xml][:ToUserName]
		@message.create_time = Time.now

		receive_log
		
		main_tree = "1.查询订单 \x0A2.录入祝福 \x0A"
		
		user = MagentoCustomer.where(wechat_user_open_id: @message.to_user_name, islocked: false).first


		
		p user
		case params[:xml][:MsgType]
		when "text"
		 	msg_text = params[:xml][:Content]
			@message.content = msg_text

			unless user.nil?
				case msg_text
				when "0"
					user.isentry = false
					user.save
					@message.content = main_tree
				when "1"
					
					logger.debug "Query User Order.  "
					@orders = TheBeast::Order.get_list(user.user_id)
					logger.debug "Query Order done.  "
					if @orders.empty?
						@message.content = "没有订单"
					else 
						render @orders, :xml, :template => 'api/orders'
					end
					# result = ""
					# orders.each do | order_item |
					# 	order = TheBeast::Order.get(order_item.order_id)
					# 	result <<  "订单号: " << order.order_id  << "\x0A" << "地址: " << order.address << "\x0A" << "备注: " << order.note << "\x0A\x0A"
					# end
					# @message.content = result.empty? ? "没有订单" : result
				when "2"
					user.isentry = true
					user.save
					@message.content = "请输入祝福的文字或图片,输入 0  退出录入祝福"
				else
					if user.isentry
						order_no = TheBeast::Order.get_list(user.user_id)[0].order_id
						user.saveCards(order_no, @message.to_user_name, msg_text, nil)
						#Card.save(order_no, @message.to_user_name, msg_text, nil)
						
						@message.content = "保存成功！\x0A请输入祝福的文字或图片,输入 0  退出录入祝福"
					else
						@message.content = "无法理解您的输入，请重新按菜单输入 \x0A" + main_tree
					end

				end
				
			else
				@message.content = "您还未绑定TheBeast账号，<a href=\"http://wechat.thebeastshop.com/the_beast/sessions/new?open_id=" + @message.to_user_name + "\">绑定</a> \x0A"
			end
			render :xml, :template => 'api/message_text'

		when "image"
			unless user.nil? && user.isentry
				order_no = TheBeast::Order.get_list(user.user_id)[0].order_id
				user.saveCards(order_no, @message.to_user_name, nil, CardImage.down(params[:xml][:PicUrl]))
				#Card.save(order_no, @message.to_user_name, nil, CardImage.down(params[:xml][:PicUrl]))	
				
				@message.content = "保存成功！,请继续输入文字或图片， 按 0 退出录入祝福"
			else
				@message.content = "我们收到了您的图片信息"
			end
			
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
		
	end

	private
	def receive_log
		from_user_name = params[:xml][:FromUserName]
		to_user_name = params[:xml][:ToUserName]
		type = params[:xml][:MsgType]
		msg_id = params[:xml][:MsgId]
		create_time = params[:xml][:CreateTime]

		case type
		when "text"
			MessageReceiveText.save(from_user_name,to_user_name,type,msg_id,Time.now,params[:xml][:Content])
		when "image"
			MessageReceiveImage.save(from_user_name,to_user_name,type,msg_id,Time.now,params[:xml][:PicUrl])
		when "voice"
			MessageReceiveVoice.save(from_user_name,to_user_name,type,msg_id,Time.now,params[:xml][:MediaId],params[:xml][:Format],params[:xml][:Recognition])
		when "location"
			MessageReceiveLocation.save(from_user_name,to_user_name,type,msg_id,Time.now,params[:xml][:Scale],params[:xml][:Location_X],params[:xml][:Location_Y],params[:xml][:Label])
		when "event"
			MessageReceiveEvent.save(from_user_name,to_user_name,type,msg_id,Time.now,params[:xml][:Event],params[:xml][:EventKey])
		end
	end

end

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


