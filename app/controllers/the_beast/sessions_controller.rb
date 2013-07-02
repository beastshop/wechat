# encoding: utf-8
class TheBeast::SessionsController < TheBeast::ApplicationController
	# layout "application"

	def new
		
	end

	def create
		customer = TheBeast::Customer.login(params[:email], params[:password])
		if customer && !MagentoCustomer.where(wechat_user_open_id: params[:open_id]).exists?

			c = MagentoCustomer.new
			c.user_id = customer.user_id
			c.email = customer.email

			user = WechatUser.new
			user.name = "from wechat api"
			user.open_id = params[:open_id]
			user.magento_customer = c
			user.save

			redirect_to :action => "success"
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
