class CreateMessageReceiveTexts < ActiveRecord::Migration
  def change
    create_table :message_receive_texts do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.text :content
      t.integer :msg_id, :limit => 8
      t.text :origin_source
      t.belongs_to :message_receive
      t.timestamps
    end
  end
end
