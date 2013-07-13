class CreateMessageReceives < ActiveRecord::Migration
  def change
    create_table :message_receives do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :ceate_time
      t.string :msg_type
      t.integer :msg_id

      t.timestamps
    end
  end
end
