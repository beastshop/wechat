require 'rqrcode'
require 'digest' 
class CardsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show]
	layout 'card_layout', :only => [:show]

	def show
		@card = Card.where(:url => params[:id]).first
		if !@card.nil?
			@card.write_log(request.remote_ip, request.headers["User-Agent"], !params[:user].nil?)
		else
			render 'default_card.html.erb'
		end
		
	end

	def index_byuser
		@user = MagentoCustomer.find(params[:uid])
	end

	def index
		@cards = params[:key].nil? ? Card.page(params[:page]).per(20) : Card.where("order_no like '%#{params[:key]}%'").page(params[:page]).per(20)

	end

	def show_code
		card = Card.find(params[:id])
		unless card.nil?
			url = request.protocol << request.host_with_port << '/cards/' << Digest::MD5.hexdigest(card.order_no).to_s
			p url
			@qr = RQRCode::QRCode.new(url, :size => 8, :level => :l)
		end
	end

	
end
