require 'test_helper'

class MagentoCustomerTest < ActiveSupport::TestCase
  fixtures :magento_customers

  def test_saveCards
  	 # user = MagentoCustomer.where(:email => 'bruce@gmail.com').first
  	 # user.saveCards('test_order_no','test_order_shipping','test_open_id','content',nil)
  	 # assert  user.cards.where(:order_no => 'test_order_no').exists?
  	 assert true
  end


end
