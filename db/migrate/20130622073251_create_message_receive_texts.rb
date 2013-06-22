class CreateMessageReceiveTexts < ActiveRecord::Migration
  def change
    create_table :message_receive_texts do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.text :content
      t.long :msg_id
      t.text :origin_source

      t.timestamps
    end
  end
end
