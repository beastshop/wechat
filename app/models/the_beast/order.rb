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
		 	#if o.status=="pending" then orders << o end
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

			# order.order_items = []

			# result.attributes["items"].each do |item|
			# 	i = TheBeast::OrderItem.new
			# 	i.item_id = item["item_id"]
			# 	i.name_en = item["name"]
			# 	i.name_zh = item["name"]
			# 	i.price = item["price"]
			# 	i.product_id = item["product_id"]
			# 	i.qty = item["qty_ordered"]
			# 	i.image = ""
			# 	i.update_time = item["updated_at"]
			# 	order.order_items << i
			# end

			p order
			return order
		end
	end
end



# This is an Order sample, which extracted from OrderList
# array(171) { 
# 	["state"]=> string(8) "complete" 
# 	["status"]=> string(8) "complete" 
# 	["coupon_code"]=> NULL 
# 	["protect_code"]=> string(6) "76c897" 
# 	["shipping_description"]=> NULL 
# 	["is_virtual"]=> string(1) "0" 
# 	["store_id"]=> string(1) "4" 
# 	["customer_id"]=> string(6) "109572" 
# 	["base_discount_amount"]=> string(6) "0.0000" 
# 	["base_discount_canceled"]=> NULL 
# 	["base_discount_invoiced"]=> string(6) "0.0000" 
# 	["base_discount_refunded"]=> NULL 
# 	["base_grand_total"]=> string(8) "500.0000" 
# 	["base_shipping_amount"]=> string(6) "0.0000" 
# 	["base_shipping_canceled"]=> NULL 
# 	["base_shipping_invoiced"]=> string(6) "0.0000" 
# 	["base_shipping_refunded"]=> NULL 
# 	["base_shipping_tax_amount"]=> string(6) "0.0000" 
# 	["base_shipping_tax_refunded"]=> NULL 
# 	["base_subtotal"]=> string(8) "500.0000" 
# 	["base_subtotal_canceled"]=> NULL 
# 	["base_subtotal_invoiced"]=> string(8) "500.0000" 
# 	["base_subtotal_refunded"]=> NULL 
# 	["base_tax_amount"]=> string(6) "0.0000" 
# 	["base_tax_canceled"]=> NULL 
# 	["base_tax_invoiced"]=> string(6) "0.0000" 
# 	["base_tax_refunded"]=> NULL 
# 	["base_to_global_rate"]=> string(6) "1.0000" 
# 	["base_to_order_rate"]=> string(6) "1.0000" 
# 	["base_total_canceled"]=> NULL 
# 	["base_total_invoiced"]=> string(8) "500.0000" 
# 	["base_total_invoiced_cost"]=> string(6) "0.0000" 
# 	["base_total_offline_refunded"]=> NULL 
# 	["base_total_online_refunded"]=> NULL 
# 	["base_total_paid"]=> string(8) "500.0000" 
# 	["base_total_qty_ordered"]=> NULL 
# 	["base_total_refunded"]=> NULL 
# 	["discount_amount"]=> string(6) "0.0000" 
# 	["discount_canceled"]=> NULL 
# 	["discount_invoiced"]=> string(6) "0.0000" 
# 	["discount_refunded"]=> NULL 
# 	["grand_total"]=> string(8) "500.0000" 
# 	["shipping_amount"]=> string(6) "0.0000" 
# 	["shipping_canceled"]=> NULL 
# 	["shipping_invoiced"]=> string(6) "0.0000" 
# 	["shipping_refunded"]=> NULL 
# 	["shipping_tax_amount"]=> string(6) "0.0000" 
# 	["shipping_tax_refunded"]=> NULL 
# 	["store_to_base_rate"]=> string(6) "1.0000" 
# 	["store_to_order_rate"]=> string(6) "1.0000" 
# 	["subtotal"]=> string(8) "500.0000" 
# 	["subtotal_canceled"]=> NULL 
# 	["subtotal_invoiced"]=> string(8) "500.0000" 
# 	["subtotal_refunded"]=> NULL 
# 	["tax_amount"]=> string(6) "0.0000" 
# 	["tax_canceled"]=> NULL 
# 	["tax_invoiced"]=> string(6) "0.0000" 
# 	["tax_refunded"]=> NULL 
# 	["total_canceled"]=> NULL 
# 	["total_invoiced"]=> string(8) "500.0000" 
# 	["total_offline_refunded"]=> NULL 
# 	["total_online_refunded"]=> NULL 
# 	["total_paid"]=> string(8) "500.0000" 
# 	["total_qty_ordered"]=> string(6) "1.0000" 
# 	["total_refunded"]=> NULL 
# 	["can_ship_partially"]=> NULL 
# 	["can_ship_partially_item"]=> NULL 
# 	["customer_is_guest"]=> string(1) "0" 
# 	["customer_note_notify"]=> string(1) "1" 
# 	["billing_address_id"]=> string(5) "15189" 
# 	["customer_group_id"]=> string(1) "1" 
# 	["edit_increment"]=> NULL 
# 	["email_sent"]=> string(1) "1" 
# 	["forced_shipment_with_invoice"]=> NULL 
# 	["forced_do_shipment_with_invoice"]=> NULL 
# 	["gift_message_id"]=> string(4) "3986" 
# 	["payment_auth_expiration"]=> NULL 
# 	["payment_authorization_expiration"]=> NULL 
# 	["paypal_ipn_customer_notified"]=> NULL 
# 	["quote_address_id"]=> NULL 
# 	["quote_id"]=> string(5) "20123" 
# 	["shipping_address_id"]=> string(5) "15190" 
# 	["adjustment_negative"]=> NULL 
# 	["adjustment_positive"]=> NULL 
# 	["base_adjustment_negative"]=> NULL 
# 	["base_adjustment_positive"]=> NULL 
# 	["base_shipping_discount_amount"]=> string(6) "0.0000" 
# 	["base_subtotal_incl_tax"]=> string(8) "500.0000" 
# 	["base_total_due"]=> string(6) "0.0000" 
# 	["payment_authorization_amount"]=> NULL 
# 	["shipping_discount_amount"]=> string(6) "0.0000" 
# 	["subtotal_incl_tax"]=> string(8) "500.0000" 
# 	["total_due"]=> string(6) "0.0000" 
# 	["weight"]=> string(6) "0.0000" 
# 	["customer_dob"]=> NULL 
# 	["increment_id"]=> string(9) "400007509" 
# 	["applied_rule_ids"]=> NULL 
# 	["base_currency_code"]=> string(3) "CNY" 
# 	["customer_email"]=> string(21) "never_forget@yeah.net" 
# 	["customer_firstname"]=> string(6) "暖暖" 
# 	["customer_lastname"]=> string(6) "暖暖" 
# 	["customer_middlename"]=> NULL 
# 	["customer_prefix"]=> NULL 
# 	["customer_suffix"]=> string(6) "女士" 
# 	["customer_taxvat"]=> NULL 
# 	["discount_description"]=> NULL 
# 	["ext_customer_id"]=> NULL 
# 	["ext_order_id"]=> NULL 
# 	["global_currency_code"]=> string(3) "CNY" 
# 	["hold_before_state"]=> NULL 
# 	["hold_before_status"]=> NULL 
# 	["order_currency_code"]=> string(3) "CNY" 
# 	["original_increment_id"]=> NULL 
# 	["relation_child_id"]=> NULL 
# 	["relation_child_real_id"]=> NULL 
# 	["relation_parent_id"]=> NULL 
# 	["relation_parent_real_id"]=> NULL 
# 	["remote_ip"]=> string(12) "60.191.20.66" 
# 	["shipping_method"]=> string(25) "freeshipping_freeshipping" 
# 	["store_currency_code"]=> string(3) "CNY" 
# 	["store_name"]=> string(29) "主网站 总店 中文店面" 
# 	["x_forwarded_for"]=> NULL 
# 	["customer_note"]=> NULL 
# 	["created_at"]=> string(19) "2013-03-01 00:10:15" 
# 	["updated_at"]=> string(19) "2013-03-06 02:41:07" 
# 	["total_item_count"]=> string(1) "1" 
# 	["customer_gender"]=> NULL 
# 	["base_custbalance_amount"]=> NULL 
# 	["currency_base_id"]=> NULL 
# 	["currency_code"]=> NULL 
# 	["currency_rate"]=> NULL 
# 	["custbalance_amount"]=> NULL 
# 	["is_hold"]=> NULL 
# 	["is_multi_payment"]=> NULL 
# 	["real_order_id"]=> NULL 
# 	["tax_percent"]=> NULL 
# 	["tracking_numbers"]=> NULL 
# 	["hidden_tax_amount"]=> string(6) "0.0000" 
# 	["base_hidden_tax_amount"]=> string(6) "0.0000" 
# 	["shipping_hidden_tax_amount"]=> string(6) "0.0000" 
# 	["base_shipping_hidden_tax_amnt"]=> string(6) "0.0000" 
# 	["base_shipping_hidden_tax_amount"]=> string(6) "0.0000" 
# 	["hidden_tax_invoiced"]=> string(6) "0.0000" 
# 	["base_hidden_tax_invoiced"]=> string(6) "0.0000" 
# 	["hidden_tax_refunded"]=> NULL 
# 	["base_hidden_tax_refunded"]=> NULL 
# 	["shipping_incl_tax"]=> string(6) "0.0000" 
# 	["base_shipping_incl_tax"]=> string(6) "0.0000" 
# 	["coupon_rule_name"]=> NULL 
# 	["bank"]=> string(9) "directPay" 
# 	["ni_ming"]=> string(1) "0" 
# 	["special_time"]=> string(0) "" 
# 	["customer_comment"]=> string(138) "Customer Comment:卡片内容受字符限制不能排版，麻烦稍微排一下，另请在3月7日中午12点前送达，万分感谢！" 
# 	["gift_method"]=> string(1) "2" 
# 	["rma_status"]=> string(1) "0" 
# 	["order_item_devetime"]=> string(20) "桃花运:2013-03-07" 
# 	["invoice_create_time"]=> NULL 
# 	["first_order"]=> string(1) "0" 
# 	["non_paid_customer"]=> string(1) "0" 
# 	["black_list_order"]=> string(1) "0" 
# 	["firstname"]=> string(9) "赵建梅" 
# 	["lastname"]=> string(9) "赵建梅" 
# 	["telephone"]=> string(11) "15381183257" 
# 	["postcode"]=> string(6) "310000" 
# 	["billing_firstname"]=> string(9) "赵建梅" 
# 	["billing_lastname"]=> string(9) "赵建梅" 
# 	["shipping_firstname"]=> string(9) "赵建梅" 
# 	["shipping_lastname"]=> string(9) "赵建梅" 
# 	["billing_name"]=> string(19) "赵建梅 赵建梅" 
# 	["shipping_name"]=> string(19) "赵建梅 赵建梅" 
# 	["order_id"]=> string(4) "7595" 
# } 




