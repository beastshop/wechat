require 'test_helper'

class MagentoCustomerTest < ActiveSupport::TestCase
  fixtures :magento_customers
  fixtures :cards
  fixtures :card_images

  def test_saveCards
  	 user = MagentoCustomer.where(:email => 'bruce@gmail.com').first
  	 user.saveCards('test_order_no','test_order_shipping','test_open_id','content',nil)
  	 assert  user.cards.where(:order_no => 'test_order_no').exists?
  end


end
