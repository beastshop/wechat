class MagentoCustomersController < ApplicationController
	before_filter :authenticate_user!
	def index
		@users = MagentoCustomer.all.order('created_at DESC')
		# user = MagentoCustomer.first
		# user.isentry = true
	
		# user.saveCards("order_no","wechat_user_open_id","content23gogogo","image_urlasd11")
		# p user
	end

	def destroy
	    @user = MagentoCustomer.find(params[:id])
	    @user.islocked = true
	    @user.save

	    redirect_to magento_customers_url
  	end
end
