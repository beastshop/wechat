require "open-uri"
require 'fileutils'

class CardImage < ActiveRecord::Base
  attr_accessible :order_no, :title, :wechat_user_open_id, :url
  belongs_to :card

  def self.get_file_url(url)
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
  	 
     return image_url
  end

end
