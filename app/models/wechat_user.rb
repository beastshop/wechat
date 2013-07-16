class WechatUser < ActiveRecord::Base
  attr_accessible :name, :open_id, :is_subscribe
  has_one :magento_customer, :foreign_key => "wechat_user_open_id", :primary_key => "open_id"

  def self.subscribe(open_id)
  	user = WechatUser.new
  	if WechatUser.where(:open_id => open_id).exists?
  	 	user = WechatUser.where(:open_id => open_id).first
  	end 
  	
  	user.open_id = open_id
  	user.is_subscribe = true
  	user.save
  end

  def self.unsubscribe(open_id)
  	user = WechatUser.where(:open_id => open_id).first
  	user.is_subscribe = false
  	user.save
  end
end
