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
		p @message
		case params[:xml][:MsgType]
		when "text"
			@message.content = "我们收到了您的文本信息"
			msg_text = params[:xml][:Content]

			@mkw = MessageKeyword.where("content like '%#{msg_text}%'").first

			if !@mkw.nil?
				if @mkw.message_auto_reply_texts.size > 0
					@message.content = @mkw.message_auto_reply_texts.first.content
					render :xml, :template => 'api/message_text'
				elsif @mkw.message_auto_reply_musics.size > 0
					@message = MessageSendMusic.new
					@message.to_user_name = params[:xml][:FromUserName]
					@message.from_user_name = params[:xml][:ToUserName]
					@message.create_time = Time.now
					@message.music_url = request.host_with_port << @mkw.message_auto_reply_musics.first.music_url.to_s
					@message.hq_music_url = request.host_with_port << @mkw.message_auto_reply_musics.first.hq_music_url.to_s
					p @message
					render :xml, :template => 'api/message_music'
				end
					

			end



		when "image"
			@message.content = "我们收到了您的图片信息"
			render :xml, :template => 'api/message_text'
		when "location"
			@message.content = "我们收到了您的位置信息"
			render :xml, :template => 'api/message_text'
		when "voice"
			@message.content = "我们收到了您的留言信息"
			render :xml, :template => 'api/message_text'
		end
		p @message
	end

end
