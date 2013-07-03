class CardsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]
	def show
		@cards = Card.where(:order_no => params[:id])
		@card_images = CardImage.where(:order_no => params[:id])
	end

	def index_byuser
		@user = MagentoCustomer.find(params[:uid])
		@cards = Card.where(:wechat_user_open_id => @user.wechat_user_open_id)
		@card_images = CardImage.where(:wechat_user_open_id => @user.wechat_user_open_id)
	end
end
