# encoding: utf-8
class Api::CommonController < Api::ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source
	layout false

	def test
		render :text => params[:echostr]
	end

	def echo
		@message = message_send_init
		
		# Write receive message log
		receive_log
		template_text = "api/message_text"
		template_music = "api/message_music"
		template_news = "api/message_news"
		template_result = ""

		user = MagentoCustomer.where(wechat_user_open_id: @message.to_user_name, islocked: false).first
		user_session = UserSession.where(open_id: @message.to_user_name).first
		if user_session.nil?
			WechatUser.subscribe(@message.to_user_name)
		end

		main_menu = "输入【1】或【dd】或【订单】查看您的订单状态 \x0A输入【2】或【zf】或【祝福】录入祝福 \x0A"
		if !user_session.nil? && Card.where(order_no: user_session.order_no).exists?
			main_menu << "输入【8】查看最新录制的祝福内容 \x0A输入【9】查看祝福阅读时间 "
		end

		entry_msg = "您可以为最新订单录制祝福文字和图片"
		no_match_msg = "不太明白您的意思。 \x0A" + main_menu
		account_bind_msg = "您还未绑定BeastShop网站账号，<a href=\"" + request.protocol + request.host_with_port + "/the_beast/sessions/new?open_id=" + @message.to_user_name + "\">去登录绑定</a> \x0A"
		case params[:xml][:MsgType]
		when "text"
			msg_text = params[:xml][:Content]
			if !user.nil? && user_session.is_entry
				case msg_text
				when "51"
					user_session.exit_entry
					@message.save_text(main_menu)
				when "81"
					user_session.exit_entry
					Card.destroy_by_order_no(user_session.order_no)
					@message.save_text("操作成功!" + main_menu)
				else
					if user_session.is_expired
						user_session.exit_entry
						@message.save_text("之前的编辑操作已超时，" + main_menu)
					else
						user.saveCards(user_session.order_no,user_session.order_shipping_name, @message.to_user_name, msg_text, nil)
						@message.save_text("您可以继续输入，我们会将您最后输入的信息作为祝福贺卡内容。输入“51”结束编辑。输入“81”取消发送祝福" )
					end
				end
				template_result = template_text
			elsif !user.nil? && !user_session.is_entry
				case msg_text
			 	when "1","dd","订单"
	 				result = TheBeast::Order.show_order(user.user_id)
					@message.save_text(result.empty? ? "没有订单" : result)
			 		template_result = template_text	
			 	when "2","zf","祝福"
			 		user_session.begin_entry(user.user_id)
			 		card = Card.where(order_no: user_session.order_no).first

			 		result = ""
			 		if user_session.is_entry && card.nil?
			 		 	result << "您可以为最新订单【" << user_session.order_no << "】收货人【" << user_session.order_shipping_name << "】保存祝福文字和图片"
			 		elsif user_session.is_entry && !card.nil?
			 		  	result << "您已经为最新订单【" << user_session.order_no << "】收货人【" << user_session.order_shipping_name << "】制作了祝福卡。您可以继续输入，我们会将您最后输入的信息作为祝福贺卡内容。输入【51】结束编辑。输入【81】取消发送祝福"
			 		else
			 			result << "您没有可录入祝福的订单"
			 		end
			 		
					@message.save_text(result)
					template_result = template_text
				when "8"
					@message.save_text(Card.wechat_review(user.wechat_user_open_id))
					template_result = template_text
			 	when "9"		 		
					@message.save_text(Card.get_read_time(user.wechat_user_open_id))
					template_result = template_text	
				else
					template_result = macth_keywords(@message, msg_text, no_match_msg)
		 		end
			else
				case msg_text
				when "1","2","8","9","dd","订单","zf","祝福"
					@message.save_text(account_bind_msg)
					template_result = template_text
				else
					template_result = macth_keywords(@message, msg_text, no_match_msg)
				end
			end
		when "image"
			if !user.nil? && user_session.is_entry && user_session.is_expired
					user_session.exit_entry
					@message.save_text("之前的编辑操作已超时，" + main_menu)
			elsif !user.nil? && user_session.is_entry && !user_session.is_expired
					#save_greetings_images(user, @message.to_user_name, params[:xml][:PicUrl])
					user.delay.deliver(user_session.order_no,user_session.order_shipping_name, @message.to_user_name, params[:xml][:PicUrl])
					@message.save_text("您可以继续输入，我们会将您最后输入的信息作为祝福贺卡内容。输入“51”结束编辑。输入“81”取消发送祝福" )
			else
				@message.save_text("我们收到了您的图片")
			end
			template_result = template_text
		when "location"
			@message.save_text("我们收到了您的位置信息")
			template_result = template_text
		when "voice"
			if !user.nil? && user_session.is_entry
				@message.save_text("我们还无法保存您的语音留言")
			else
				@message.save_text("我们还无法识别您的语音留言")
			end
			template_result = template_text
		when "event"
			case params[:xml][:Event]
			when "subscribe"
				WechatUser.subscribe(@message.to_user_name)
				template_result = macth_keywords(@message, "event", '感谢您的关注' + main_menu)
			when "unsubscribe"
				WechatUser.unsubscribe(@message.to_user_name)
				template_result = template_text
			end
		end
		@message.save
		render :xml, :template => template_result
	end

	private
	

	
	def message_send_init
		message_send = MessageSend.new

		message_send.from_user_name = params[:xml][:ToUserName]
		message_send.to_user_name = params[:xml][:FromUserName]
		# message_send.msg_type = params[:xml][:MsgType]
		message_send.create_time = Time.now

		return message_send
	end

	def receive_log
		message_receive = MessageReceive.new

		message_receive.from_user_name = params[:xml][:FromUserName]
		message_receive.to_user_name = params[:xml][:ToUserName]
		message_receive.msg_type = params[:xml][:MsgType]
		message_receive.msg_id = params[:xml][:MsgId]
		message_receive.create_time = Time.at(params[:xml][:CreateTime].to_i).to_datetime

		case params[:xml][:MsgType]
		when "text"
			message_receive.save_text(params[:xml][:Content])
		when "image"
			message_receive.save_image(params[:xml][:PicUrl])
		when "voice"
			message_receive.save_voice(params[:xml][:MediaId],params[:xml][:Format],params[:xml][:Recognition])
		when "location"
			message_receive.save_location(params[:xml][:Scale],params[:xml][:Location_X],params[:xml][:Location_Y],params[:xml][:Label])
		when "event"
			message_receive.save_event(params[:xml][:Event],params[:xml][:EventKey])
		when "link"
			message_receive.save_link(params[:xml][:Description],params[:xml][:Title],params[:xml][:Url])
		end
		message_receive.save
	end

	def macth_keywords(message, msg_text, no_match_msg)
		template_result = "api/message_text"		

		mkw = MessageKeyword.where("locate(content,'#{msg_text}')>0").first
		logger.debug  mkw
		if !mkw.nil?
			if mkw.message_auto_reply_texts.size > 0
				message.save_text(mkw.message_auto_reply_texts.first.content)
				template_result = "api/message_text"
			elsif mkw.message_auto_reply_musics.size > 0
				logger.debug 'in  music'
				music_url = request.protocol + request.host_with_port + mkw.message_auto_reply_musics.first.music_url.to_s
				hq_music_url = request.protocol + request.host_with_port + mkw.message_auto_reply_musics.first.hq_music_url.to_s
				message.save_music(hq_music_url,music_url,mkw.message_auto_reply_musics.first.title,mkw.message_auto_reply_musics.first.description)
				template_result = "api/message_music"
			elsif mkw.message_auto_reply_news.size > 0
				message.save_news(mkw.message_auto_reply_news.first,request.protocol + request.host_with_port)
				template_result = "api/message_news"
			end
		else
			message.save_text(no_match_msg)
			template_result = "api/message_text"
		end

		return template_result
	end


end




