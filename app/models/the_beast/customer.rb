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
				c = TheBeast::Customer.new
				c.user_id = customer.customer_id
				c.email = customer.email
				return c
			end
		end
	end
end