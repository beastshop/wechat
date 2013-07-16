class MagentoCustomersController < ApplicationController
	before_filter :authenticate_user!
	def index
		@users = MagentoCustomer.all
	end

	def destroy
	    @user = MagentoCustomer.find(params[:id])
	    @user.islocked = true
	    @user.save

	    redirect_to magento_customers_url
  	end
end
