class WechatUser < ActiveRecord::Base
  attr_accessible :name, :open_id
  has_one :magento_customer, :foreign_key => "wechat_user_open_id", :primary_key => "open_id"
end
