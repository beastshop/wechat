class CreateMessageSendNews < ActiveRecord::Migration
  def change
    create_table :message_send_news do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.integer :article_count
      t.string :func_flag

      t.timestamps
    end
  end
end
