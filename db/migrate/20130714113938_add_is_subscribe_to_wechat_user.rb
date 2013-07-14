class AddIsSubscribeToWechatUser < ActiveRecord::Migration
  def change
    add_column :wechat_users, :is_subscribe, :boolean
  end
end
