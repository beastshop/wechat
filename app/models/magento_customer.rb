class MagentoCustomer < ActiveRecord::Base
  attr_accessible :email, :user_id, :wechat_user_open_id

  def self.bind_to_wechat(wechat_id, email, password)
  	#Magento::Customer
  end
end
