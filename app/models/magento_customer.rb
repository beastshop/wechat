require "open-uri"
require 'fileutils'

class MagentoCustomer < ActiveRecord::Base
  attr_accessible :email, :user_id, :wechat_user_open_id, :isentry, :islocked
  has_many :cards
  default_scope order: 'id desc'
  
  def saveCards(order_no,order_shipping_name,wechat_user_open_id,content,image_url)
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
    card.order_shipping_name = order_shipping_name
    card.card_image.order_no = order_no
    card.card_image.wechat_user_open_id = wechat_user_open_id
    card.url = Digest::MD5.hexdigest(order_no).to_s
    self.cards << card
    self.save

	end

  def deliver(order_no,order_shipping_name, wechat_user_open_id, url)
     logger.debug "GO  TO   DELIVER"
     unless File.exist?("public/down_files/")
       FileUtils.mkdir_p 'public/down_files'
     end

     e = case open(url).meta["content-type"]
     when "image/jpeg" then ".jpg"
     when "image/png" then ".png"  
     when "image/gif" then ".gif"
     when "image/bmp" then ".bmp"  
     end
     p e

    image_url = "/down_files/"+SecureRandom.uuid+e
     
    data = open(url){|f|f.read}
    open("public"+image_url,"wb"){|f|f.write(data)}
    
    saveCards(order_no, order_shipping_name, wechat_user_open_id, nil, image_url)
    
  end
  handle_asynchronously :deliver
end
