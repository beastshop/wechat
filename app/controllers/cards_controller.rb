require 'base64' 

class CardsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]

	def show
		@card = Card.where(:order_no => Base64.decode64(params[:id])).first
		if @card.nil?
			@card = Card.get_default(Base64.decode64(params[:id]))
		end
		render layout: nil
	end

	def index_byuser
		@user = MagentoCustomer.find(params[:uid])
		@cards = Card.where(:wechat_user_open_id => @user.wechat_user_open_id)
		@card_images = CardImage.where(:wechat_user_open_id => @user.wechat_user_open_id)


	end

	def index
		@cards = Card.all
		# @cards.each do |card|
		# 	enc =  Base64.encode64(card.order_no)
		# 	p enc
		# 	p Base64.decode64(enc)
		# end
	end
end
