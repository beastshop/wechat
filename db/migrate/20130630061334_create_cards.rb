class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :order_no
      t.string :wechat_user_open_id
      t.string :content
      t.datetime :first_read_time
      t.belongs_to :magento_customer
      t.timestamps
    end
  end
end
