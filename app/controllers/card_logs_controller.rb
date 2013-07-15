class CardLogsController < ApplicationController
 before_filter :authenticate_user!	
	def index
		order_no = params[:order_no]

		@card_logs = order_no.nil? ? CardLog.all : CardLog.joins(:card).where("cards.order_no" => order_no)
	end
end
