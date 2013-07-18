require 'digest'  

class Card < ActiveRecord::Base
  attr_accessible :order_no, :wechat_user_open_id, :content, :url, :first_read_time
  has_one :card_image, autosave: true
  belongs_to :magento_customer
  has_many :card_logs, :dependent => :destroy
  default_scope order: 'id desc' 
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

  	return card
  end

  def write_log(host, brower,is_admin)
    log = CardLog.new
    log.host = host
    log.brower = brower
    log.is_admin_read = is_admin

    if !is_admin && self.first_read_time.nil?
      self.first_read_time = Time.now
    end

    self.card_logs << log
    self.save
  end

  def self.destroy_by_order_no(order_no)
    card = Card.where(:order_no => order_no).first
    unless card.nil?
      card.card_logs.destroy_all
      card.card_image.destroy
      card.destroy 
    end
  end

  def self.get_read_time(open_id)
      result = ""
      card = Card.where(:wechat_user_open_id => open_id).first
      if card.nil?
        result = "您还没有录入祝福!"
      elsif !card.nil? && card.first_read_time.nil?
        result = "您的祝福未被阅读"
      else
        result = "您的祝福被阅读时间: " + card.first_read_time.to_s
      end

      return result
  end
end
