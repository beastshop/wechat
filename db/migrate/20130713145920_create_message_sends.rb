class CreateMessageSends < ActiveRecord::Migration
  def change
    create_table :message_sends do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :ceate_time
      t.string :msg_type
      t.string :func_flag
      
      t.timestamps
    end
  end
end
