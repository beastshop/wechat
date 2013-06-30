require 'magentor'

class TheBeast::Order
	attr_accessor :order_code, :status, :order_id, :order_status, :payment_status, :total_price, :address, :note, :order_items
	
	def self.get_list(customer_id)
		orders = []

		array = { "customer_id" => customer_id }
		results = Magento::Order.list(array)
		results.each do |result|
			o = TheBeast::Order.new
			#o.order_id = result.attributes["order_id"]
			o.order_id = result.attributes["increment_id"]
			o.status = result.attributes["status"]
			o.total_price = result.attributes["total_due"]
			o.order_code = result.attributes["protect_code"]
			orders << o
		end

		orders
	end

	def self.get(id)
		result = Magento::Order.info(id)
		unless result.nil?
			order = TheBeast::Order.new
			order.order_id = result.attributes["increment_id"]
			order.order_status = result.attributes["status"]
			order.payment_status = result.attributes["status"]
			order.total_price = result.attributes["total_due"]
			order.note = result.attributes["customer_comment"]
			
			order.address = ""
			address = result.attributes["billing_address"]
			unless address.nil?
				order.address = address["region"] + address["city"] + address["street"] + address["postcode"] + address["firstname"]
			end

			order.order_items = []

			result.attributes["items"].each do |item|
				i = TheBeast::OrderItem.new
				i.item_id = item["item_id"]
				i.name_en = item["name"]
				i.name_zh = item["name"]
				i.price = item["price"]
				i.product_id = item["product_id"]
				i.qty = item["qty_ordered"]
				i.image = ""
				i.update_time = item["updated_at"]
				order.order_items << i
			end

			p order
			return order
		end
	end
end