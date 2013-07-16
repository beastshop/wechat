class CardLog < ActiveRecord::Base
  attr_accessible :brower, :host, :is_admin_read
  belongs_to :card
  default_scope order: 'id desc' 
end
