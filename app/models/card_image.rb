require "open-uri"
require 'fileutils'

class CardImage < ActiveRecord::Base
  attr_accessible :order_no, :title, :wechat_user_open_id
  belongs_to :card

  def self.down(url)
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

     image_url = "down_files/"+SecureRandom.uuid+e
  	 data = open(url){|f|f.read}
	   open("public/"+image_url,"wb"){|f|f.write(data)}

     return image_url
  end
end
