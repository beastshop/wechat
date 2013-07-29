require 'test_helper'

class CardTest < ActiveSupport::TestCase
	fixtures :cards

	  def test_write_log
	  	card = Card.where(:order_no => 'test_order_no').first
	  	log_count = card.card_logs.size
	  	p log_count
	  	card.write_log('host','brower',true)
	  	log_count_now = card.card_logs.size
	  	p log_count_now
	  	assert log_count == log_count_now - 1
	  end
end
