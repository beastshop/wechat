# encoding: utf-8
class TheBeast::SessionsController < TheBeast::ApplicationController
	 layout "media_application"

	def new
		
	end

	def create
		customer = TheBeast::Customer.login(params[:email], params[:password])
		if customer && MagentoCustomer.where(email: params[:email],islocked: false).size == 0

			c = MagentoCustomer.new
			c.user_id = customer.user_id
			c.email = customer.email
			c.islocked = false
			c.isentry = false
			c.cards = []

			if MagentoCustomer.where(email: params[:email],islocked: true).exists?
				MagentoCustomer.where(email: params[:email],islocked: true).last.cards.each do |card|
					c.cards << card
				end
			end

			user = WechatUser.new
			user.name = "from wechat api"
			user.open_id = params[:open_id]
			user.magento_customer = c
			user.save

			

			redirect_to :action => "success"
		elsif customer && MagentoCustomer.where(email: params[:email],islocked: false).size != 0
			@message = "已有微信账号绑定此用户，请联系管理员"

			render "new"
		else
			@message = "用户名密码错误!"

			render "new"
		end
	end

	def success
		user = WechatUser.first.magento_customer
		@orders = TheBeast::Order.get_list(user.user_id)
		p @orders
	end
end
