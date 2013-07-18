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

		main_menu = "输入【1】或【xcdd】或【订单】可以查看您的订单状态 \x0A 输入【2】或【zf】或【祝福】可以录入祝福 \x0A"
		entry_msg = "您可以为最新订单录制祝福文字和图片"
		no_match_msg = "无法理解您的输入，请重新按菜单输入 \x0A" + main_menu
		account_bind_msg = "您还未绑定TheBeast账号，<a href=\"http://wechat.thebeastshop.com/the_beast/sessions/new?open_id=" + @message.to_user_name + "\">绑定</a> \x0A"
		
		user = MagentoCustomer.where(wechat_user_open_id: @message.to_user_name, islocked: false).first
		user_session = UserSession.where(open_id: @message.to_user_name).first

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
						@message.save_text("您的操作已超时," + main_menu)
					else
						user.saveCards(user_session.order_no, @message.to_user_name, msg_text, nil)
						@message.save_text("您可以继续输入，我们会将您最后输入的信息作为祝福贺卡内容。输入“51”结束编辑。输入“81”取消发送祝福" )
					end
				end
				template_result = template_text
			elsif !user.nil? && !user_session.is_entry
				case msg_text
			 	when "1"
	 				result = TheBeast::Order.show_order(user.user_id)
					@message.save_text(result.empty? ? "没有订单" : result)
			 		template_result = template_text	
			 	when "2"
			 		user_session.begin_entry(user.user_id)
			 		card = Card.where(order_no: user_session.order_no).first

			 		result = ""
			 		if user_session.is_entry && card.nil?
			 		 	result << "您可以为最新订单 【" << user_session.order_no << "】 收货人 【" << user_session.order_shipping_name << "】 保存祝福文字和图片"
			 		elsif user_session.is_entry && !card.nil?
			 		  	result << "您已经为最新订单【" << user_session.order_no << "】 收货人 【" << user_session.order_shipping_name << "】制作了祝福卡。您可以继续输入，我们会将您最后输入的信息作为祝福贺卡内容。输入“51”结束编辑。输入“81”取消发送祝福"
			 		else
			 			result << "您还没有可录入祝福的订单"
			 		end
			 		
					@message.save_text(result)
					template_result = template_text	
			 	when "9"		 		
					@message.save_text(Card.get_read_time(user.user_id))
					template_result = template_text	
				else
					template_result = macth_keywords(@message, msg_text, no_match_msg)
		 		end
			else
				case msg_text
				when "1","2","9"
					@message.save_text(account_bind_msg)
					template_result = template_text
				else
					template_result = macth_keywords(@message, msg_text, no_match_msg)
				end
			end
		when "image"
			if !user.nil? && user_session.is_entry && user_session.is_expired
					user_session.exit_entry
					@message.save_text("您的操作已超时," + main_menu)
			elsif !user.nil? && user_session.is_entry && !user_session.is_expired
					#save_greetings_images(user, @message.to_user_name, params[:xml][:PicUrl])
					user.delay.deliver(user_session.order_no, @message.to_user_name, params[:xml][:PicUrl])
					@message.save_text("您可以继续输入，我们会将您最后输入的信息作为祝福贺卡内容。输入“51”结束编辑。输入“81”取消发送祝福" )
			else
				@message.save_text("我们收到了您的图片信息")
			end
			template_result = template_text
		when "location"
			@message.save_text("我们收到了您的位置信息")
			template_result = template_text
		when "voice"
			if !user.nil? && user_session.is_entry
				@message.save_text("您好!无法处理")
			else
				@message.save_text("我们收到了您的留言信息")
			end
			template_result = template_text
		when "event"
			case params[:xml][:Event]
			when "subscribe"
				WechatUser.subscribe(@message.to_user_name)
				@message.save_text('感谢您的关注' + main_menu)
			when "unsubscribe"
				WechatUser.unsubscribe(@message.to_user_name)
			end
			template_result = template_text
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
				message.save_music(hq_music_url,music_url)
				template_result = "api/message_music"
			elsif mkw.message_auto_reply_news.size > 0
				message.save_news(mkw.message_auto_reply_news.first)
				template_result = "api/message_news"
			end
		else
			message.save_text(no_match_msg)
			template_result = "api/message_text"
		end

		return template_result
	end


end




