class MessageAutoReplyNewsArticle < ActiveRecord::Base
  attr_accessible :description, :message_auto_reply_news_id, :pic_url, :title, :url
  belongs_to :message_auto_reply_news

  has_attached_file :pic_url, 
  					:url  => "/newspic/:attachment/:id/:style/:filename",
                    :path => ":rails_root/public/newspic/:attachment/:id/:style/:filename"

  validates_attachment :pic_url,  :content_type => { :content_type => ["image/jpeg", "image/jpg","image/png"] }

end
