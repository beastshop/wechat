class AddIsLockedToMagentoCustomer < ActiveRecord::Migration
  def change
    add_column :magento_customers, :islocked, :boolean
  end
end
