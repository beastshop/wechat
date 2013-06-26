class MessageAutoReplyMusic < ActiveRecord::Base
  attr_accessible :hq_music_url, :music_url
  has_and_belongs_to_many :message_keywords


  has_attached_file :music_url,  
                    :url  => "/musicfile/:attachment/:id/:style/:filename",
                    :path => ":rails_root/public/musicfile/:attachment/:id/:style/:filename"

  has_attached_file :hq_music_url,  
                    :url  => "/hqmusicfile/:attachment/:id/:style/:filename",
                    :path => ":rails_root/public/hqmusicfile/:attachment/:id/:style/:filename"

end
