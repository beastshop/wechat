# require "open-uri"

class MessageKeyword < ActiveRecord::Base
  attr_accessible :content
  has_and_belongs_to_many :message_auto_reply_texts
  has_and_belongs_to_many :message_auto_reply_musics
  has_and_belongs_to_many :message_auto_reply_news

  # def deliver(a)
  #   data = open("http://mmsns.qpic.cn/mmsns/Zu3yr3elPbUAic1mKCibHTqAPLpj5OHKCjxDckyVs5tN3rLLhOmeb9lg/0"){|f|f.read}
  #   open("public/down_files/"+SecureRandom.uuid+".jpg","wb"){|f|f.write(data)}
  # end
end
