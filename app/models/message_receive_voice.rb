class MessageReceiveVoice < ActiveRecord::Base
  attr_accessible  :format,  :media_id,  :recognition, :region_source
  belongs_to :message_receive
  default_scope order: 'id desc'
end
