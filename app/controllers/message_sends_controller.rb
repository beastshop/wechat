class MessageSendsController < ApplicationController
 before_filter :authenticate_user!	
	def index
		@message_sends = MessageSend.all
	end
end
