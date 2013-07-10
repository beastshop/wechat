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

			user = WechatUser.new
			user.name = "from wechat api"
			user.open_id = params[:open_id]
			user.magento_customer = c
			user.save

			if MagentoCustomer.where(email: params[:email],islocked: true).exists?
				mc = MagentoCustomer.where(email: params[:email],islocked: true).last
				Card.where(wechat_user_open_id: mc.wechat_user_open_id)
			end

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
