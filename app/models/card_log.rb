class CardLog < ActiveRecord::Base
  attr_accessible :brower, :host
  belongs_to :card
  default_scope order: 'id desc' 
end
