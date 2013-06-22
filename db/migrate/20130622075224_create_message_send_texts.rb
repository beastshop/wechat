class CreateMessageSendTexts < ActiveRecord::Migration
  def change
    create_table :message_send_texts do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.text :content
      t.string :func_flag

      t.timestamps
    end
  end
end
