class AddIsEntryToMagentoCustomer < ActiveRecord::Migration
  def change
    add_column :magento_customers, :isentry, :boolean
    add_column :magento_customers, :entry_time, :datetime
  end
end
