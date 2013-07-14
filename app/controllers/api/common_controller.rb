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

		main_menu = "1.查询订单 \x0A2.录入祝福 \x0A"
		entry_msg = "请输入祝福的文字或图片,输入 0  退出录入祝福"
		no_match_msg = "无法理解您的输入，请重新按菜单输入 \x0A" + main_menu
		account_bind_msg = "您还未绑定TheBeast账号，<a href=\"http://wechat.thebeastshop.com/the_beast/sessions/new?open_id=" + @message.to_user_name + "\">绑定</a> \x0A"
		
		user = MagentoCustomer.where(wechat_user_open_id: @message.to_user_name, islocked: false).first


		case params[:xml][:MsgType]
		when "text"
		 	msg_text = params[:xml][:Content]
		 	case msg_text
		 	when "0"
				back_main_menu(user)
				@message.save_text(main_menu)
				template_result = template_text
		 	when "1","2"
		 		unless user.nil?
		 			if msg_text == "1"
						@message.save_text(show_order(user).empty? ? "没有订单" : result)
		 			elsif msg_text == "2"
		 				begin_entry_greetings(user)
						@message.save_text(entry_msg)
		 			end
		 		else
		 			@message.save_text(account_bind_msg)
		 		end
		 		template_result = template_text
		 	else
		 		# User in not null and  entry greetings
		 		if !user.nil? && user.isentry
					save_greetings(user, @message.to_user_name, msg_text)
					@message.save_text("保存成功！" + entry_msg)
					template_result = template_text
				else
					#Keywords Match
					template_result = macth_keywords(@message, msg_text, no_match_msg)
				end
		 	end
		when "image"
			unless user.nil? && user.isentry
				save_greetings_images(user, @message.to_user_name, params[:xml][:PicUrl])
				@message.save_text("保存成功！" + entry_msg)
			else
				@message.save_text("我们收到了您的图片信息")
			end
			template_result = template_text
		when "location"
			@message.save_text("我们收到了您的位置信息")
			template_result = template_text
		when "voice"
			@message.save_text("我们收到了您的留言信息")
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
		render :xml, :template => template_result
	end

	private

	def back_main_menu(user)
		user.isentry = false
		user.save
	end

	def show_order(user)
		logger.debug "Query User Order.  "
		orders = TheBeast::Order.get_list(user.user_id)
		logger.debug "Query Order done.  "

		result = ""
		orders.each do | order_item |
			order = TheBeast::Order.get(order_item.order_id)
			result <<  "订单号: " << order.order_id  << "\x0A" << "地址: " << order.address << "\x0A" << "备注: " << order.note << "\x0A\x0A"
		end
		logger.debug "Query Order Detail done"
		return result
	end

	def begin_entry_greetings(user)
		user.isentry = true
		user.save
	end

	def save_greetings_images(user, to_user_name, pic_url)
		order_no = TheBeast::Order.get_list(user.user_id)[0].order_id
		user.saveCards(order_no, to_user_name, nil, CardImage.down(pic_url))
	end

	def save_greetings(user, to_user_name, msg_text)
		order_no = TheBeast::Order.get_list(user.user_id)[0].order_id
		user.saveCards(order_no, to_user_name, msg_text, nil)
	end

	def message_send_init
		message_send = MessageSend.new

		message_send.from_user_name = params[:xml][:ToUserName]
		message_send.to_user_name = params[:xml][:FromUserName]
		message_send.msg_type = params[:xml][:MsgType]
		message_send.create_time = Time.now

		return message_send
	end

	def receive_log
		message_receive = MessageReceive.new

		message_receive.from_user_name = params[:xml][:FromUserName]
		message_receive.to_user_name = params[:xml][:ToUserName]
		message_receive.msg_type = params[:xml][:MsgType]
		message_receive.msg_id = params[:xml][:MsgId]
		message_receive.create_time = params[:xml][:CreateTime]

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
		template_result = ""		

		mkw = MessageKeyword.where("locate(content,'#{msg_text}')>0").first

		if !mkw.nil?
			if mkw.message_auto_reply_texts.size > 0
				message.save_text(mkw.message_auto_reply_texts.first.content)
				template_result = "api/message_text"
			elsif mkw.message_auto_reply_musics.size > 0
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
	end


end




