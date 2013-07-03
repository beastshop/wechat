class MagentoCustomersController < ApplicationController
	def index
		@users = MagentoCustomer.all
	end

end
