require 'magentor'
require 'bcrypt'

class TheBeast::Customer
	attr_accessor :user_id, :email
	def self.login(email, password)
		customer = Magento::Customer.find(:first, {:email => email})
		unless customer.nil?
			bcrypt = BCrypt::Password.new(customer.password_hash)
			pass = BCrypt::Engine.hash_secret(password, bcrypt.salt)
			if pass == customer.password_hash
				c = Customer.new
				c.user_id = customer.customer_id
				c.email = customer.email
				return c
			end
		end
	end

	# def self.register(email, password, name, mobile, gender)
	# 	customer = Magento::Customer.create(:email => email, :password => password, :firstname => name, :lastname => name, :gender => 1, :website_id => 1, :store_id => 1, :group_id => 1)
	# 	unless customer.nil?
	# 		return customer
	# 	end
	# 	return nil?
	# end
end