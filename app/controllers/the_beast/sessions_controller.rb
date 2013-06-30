class TheBeast::SessionsController < TheBeast::ApplicationController
	def new
		
	end

	def create
		customer = TheBeast::Customer.login(params[:email], params[:password])
		unless customer.nil?
			
		end
	end
end
