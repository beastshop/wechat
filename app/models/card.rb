class Card < ActiveRecord::Base
  attr_accessible :order_no, :wechat_user_open_id, :content
  has_many :card_images
end
