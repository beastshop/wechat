require 'rqrcode'
require 'digest' 
class CardsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]

	def show
		@card = Card.where(:url => params[:id]).first
		if !@card.nil? && params[:user].nil?
			@card.write_log(request.remote_ip, request.headers["User-Agent"])
		end
		render layout: nil
	end

	def index_byuser
		@user = MagentoCustomer.find(params[:uid])
	end

	def index
		@cards = Card.all
	end

	def show_code
		card = Card.find(params[:id])
		unless card.nil?
			url = request.protocol << request.host_with_port << '/cards/' << Digest::MD5.hexdigest(card.order_no).to_s << '?user=admin'
			p url
			@qr = RQRCode::QRCode.new(url, :size => 4, :level => :l)
		end
	end


end
