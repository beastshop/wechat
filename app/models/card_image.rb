class CardImage < ActiveRecord::Base
  attr_accessible :order_no, :title, :wechat_user_open_id
  belongs_to :card
end
