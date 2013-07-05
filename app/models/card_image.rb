require "open-uri"
require 'fileutils'

class CardImage < ActiveRecord::Base
  attr_accessible :order_no, :title, :wechat_user_open_id
  belongs_to :card

  def self.down(url)
   	 unless File.exist?("public/down_files/")
	 	FileUtils.mkdir_p 'public/down_files'
	 end

	#"http://mmsns.qpic.cn/mmsns/Zu3yr3elPbUAic1mKCibHTqAPLpj5OHKCjxDckyVs5tN3rLLhOmeb9lg/0"
  	data=open(url){|f|f.read}

	open("public/down_files/"+SecureRandom.uuid+".jpg","wb"){|f|f.write(data)}
  end
end
