class CreateWechatUsers < ActiveRecord::Migration
  def change
    create_table :wechat_users do |t|
      t.string :open_id
      t.string :name

      t.timestamps
    end
  end
end
