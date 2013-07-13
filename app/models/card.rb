require 'digest'  

class Card < ActiveRecord::Base
  attr_accessible :order_no, :wechat_user_open_id, :content, :url
  has_one :card_image, autosave: true
  belongs_to :magento_customer
  default_scope order: :created_at
  def self.get_default(order_no)
    return save(order_no,nil,'default card content','default card image_url')
  end

 

  def self.save(order_no,wechat_user_open_id,content,image_url,user)
  	card = nil
  	if Card.where(:order_no => order_no).exists?
  		card = Card.where(:order_no => order_no).first
  	else
  		card = Card.new
  		card.card_image = CardImage.new

  	end

    unless content.nil?
      card.content = content
      card.card_image.title = content
    end
    
    unless image_url.nil?
      card.card_image.picture_file_name = image_url
    end

    card.wechat_user_open_id = wechat_user_open_id
    card.order_no = order_no
    card.card_image.order_no = order_no
    card.card_image.wechat_user_open_id = wechat_user_open_id
    card.url = Digest::MD5.hexdigest(order_no).to_s
    card.magento_customer = user

    card.save
  #  card.card_image.save

  	return card
  end
end
