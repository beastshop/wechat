class MessageSendsController < ApplicationController
 before_filter :authenticate_user!	
	def index
		@message_sends = MessageSend.page(params[:page]).per(20)
	end
end
