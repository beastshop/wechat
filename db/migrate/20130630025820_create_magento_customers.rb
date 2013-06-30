class CreateMagentoCustomers < ActiveRecord::Migration
  def change
    create_table :magento_customers do |t|
      t.string :wechat_user_open_id
      t.string :user_id
      t.string :email

      t.timestamps
    end
  end
end
