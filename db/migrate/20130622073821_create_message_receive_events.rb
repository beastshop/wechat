class CreateMessageReceiveEvents < ActiveRecord::Migration
  def change
    create_table :message_receive_events do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.string :event
      t.string :event_key
      t.text :origin_source

      t.timestamps
    end
  end
end
