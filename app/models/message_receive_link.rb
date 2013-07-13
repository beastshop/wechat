class MessageReceiveLink < ActiveRecord::Base
  attr_accessible  :description, :origin_source, :title, :url
  belongs_to :message_receive
  default_scope order: 'id desc' 
end
