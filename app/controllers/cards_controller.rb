class CardsController < ApplicationController
	def show
		@cards = Card.where(:order_no => params[:id])
		@card_images = CardImages.where(:order_no => params[:id])
	end
end
