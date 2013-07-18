class UserSession < ActiveRecord::Base
  attr_accessible :open_id, :order_no, :order_shipping_name, :status, :is_timeout, :entry_at

  def begin_entry(user_id)
  	order = Magento::Order.list(:customer_id => user_id).reverse.first
  	unless order.nil?
  		self.order_no = order.increment_id
  		self.order_shipping_name = order.shipping_firstname
  		self.status = "entry"
  		self.entry_at = Time.now
  		self.save
  	end
  end

  def exit_entry
  	self.status = "exit_entry"
  	self.save
  end

  def is_expired
  	return Time.now - (self.entry_at + 15.minutes)
  end

  def is_entry
  	return self.status == "entry"
  end
end
