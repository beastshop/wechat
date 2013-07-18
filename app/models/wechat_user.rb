class WechatUser < ActiveRecord::Base
  attr_accessible :name, :open_id, :is_subscribe
  has_one :magento_customer, :foreign_key => "wechat_user_open_id", :primary_key => "open_id", autosave: true
  has_one :user_session, autosave: true

  def self.subscribe(open_id)
  	user = WechatUser.new
  	if WechatUser.where(:open_id => open_id).exists?
  	 	user = WechatUser.where(:open_id => open_id).first
  	end 
  	
  	user.open_id = open_id
  	user.is_subscribe = true

    if user.user_session.nil?
      user_session = UserSession.new
      user.status = "subscribe"
      user_session.open_id = open_id
      user_session.is_timeout = false
      user.user_session = user_session
    end

  	user.save
  end

  def self.unsubscribe(open_id)
  	user = WechatUser.where(:open_id => open_id).first
  	user.is_subscribe = false

    user.magento_customer.islocked = true

  	user.save
  end
end
