class Api::CommonController < Api::ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source

	def test
		render :text => params[:echostr]
	end

	def echo
		case params[:xml][:MsgType]
		when "text"
		when "image"
		when "location"
		when "voice"
		end		 	 
	end

end
