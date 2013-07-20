class AddOrderShipingNameToCard < ActiveRecord::Migration
  def change
  	add_column :cards, :order_shipping_name, :string
  end
end
