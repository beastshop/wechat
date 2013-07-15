require "open-uri"

class MagentoCustomer < ActiveRecord::Base
  attr_accessible :email, :user_id, :wechat_user_open_id, :isentry, :islocked
  has_many :cards
  default_scope order: 'id desc'
  
  def saveCards(order_no,wechat_user_open_id,content,image_url)
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
    self.cards << card
    self.save

	end

  def deliver(url, save_path)
    data = open(url){|f|f.read}
    open("public"+save_path,"wb"){|f|f.write(data)}
  end
  handle_asynchronously :deliver
end
