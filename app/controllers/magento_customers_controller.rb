class MagentoCustomersController < ApplicationController
	before_filter :authenticate_user!
	def index
		@users = params[:key].nil? ? MagentoCustomer.page(params[:page]).per(20) : MagentoCustomer.where("wechat_user_open_id like '%#{params[:key]}%' or email like '%#{params[:key]}%'").page(params[:page]).per(20)

	end

	def destroy
	    @user = MagentoCustomer.find(params[:id])
	    @user.islocked = true
	    @user.save

	    redirect_to magento_customers_url
  	end
end
