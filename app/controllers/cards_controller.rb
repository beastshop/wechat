class CardsController < ApplicationController
	def show
		@cards = Card.where(:order_no => params[:order_no])
		@card_images = CardImages.where(:order_no => params[:order_no])
	end
end
