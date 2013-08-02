# encoding: utf-8
require 'digest'  

class Card < ActiveRecord::Base
  attr_accessible :order_no, :wechat_user_open_id, :content, :url, :first_read_time, :order_shipping_name
  has_one :card_image, autosave: true
  belongs_to :magento_customer
  has_many :card_logs, :dependent => :destroy
  default_scope order: 'id desc'
 
  # def self.get_default(order_no)
  #   return save(order_no,nil,'default card content','default card image_url')
  # end

  # def self.save(order_no,order_shipping_name,wechat_user_open_id,content,image_url,user)
  # 	card = nil
  # 	if Card.where(:order_no => order_no).exists?
  # 		card = Card.where(:order_no => order_no).first
  # 	else
  # 		card = Card.new
  # 		card.card_image = CardImage.new

  # 	end

  #   unless content.nil?
  #     card.content = content
  #     card.card_image.title = content
  #   end
    
  #   unless image_url.nil?
  #     card.card_image.picture_file_name = image_url
  #   end

  #   card.wechat_user_open_id = wechat_user_open_id
  #   card.order_no = order_no
  #   card.order_shipping_name = order_shipping_name
  #   card.card_image.order_no = order_no
  #   card.card_image.wechat_user_open_id = wechat_user_open_id
  #   card.url = Digest::MD5.hexdigest(order_no).to_s
  #   card.magento_customer = user

  #   card.save

  # 	return card
  # end

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
        result = "订单" + card.order_no.to_s + "送给【" + card.order_shipping_name + "】的祝福还没被阅读过"
      else
        result = "订单" + card.order_no.to_s + "送给【" + card.order_shipping_name + "】的祝福第一次被阅读的时间是" + card.first_read_time.strftime('%Y年%m月%d日 %H:%M')
      end

      return result
  end

  def self.wechat_review(open_id)
    result = ""
    card = Card.where(:wechat_user_open_id => open_id).first
    if card.nil?
      result = "没有可查看的祝福"
    else
      result = "<a href=\"" + self.class.get_host + "/cards/" + card.url + "\">点击查看</a> 您为订单【" << card.order_no.to_s << "】收货人【" << card.order_shipping_name << "】保存的祝福"
    end
    return result
  end

  def get_host
    return request.protocol + request.host_with_port
  end

end


