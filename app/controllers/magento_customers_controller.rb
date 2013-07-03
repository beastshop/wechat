class MagentoCustomersController < ApplicationController
	before_filter :authenticate_user!
	def index
		@users = MagentoCustomer.all
	end

end
