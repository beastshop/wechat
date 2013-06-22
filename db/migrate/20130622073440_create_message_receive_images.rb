class CreateMessageReceiveImages < ActiveRecord::Migration
  def change
    create_table :message_receive_images do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.string :pic_url
      t.long :msg_id
      t.text :origin_source

      t.timestamps
    end
  end
end
