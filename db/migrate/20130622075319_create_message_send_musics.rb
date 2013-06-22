class CreateMessageSendMusics < ActiveRecord::Migration
  def change
    create_table :message_send_musics do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.datetime :create_time
      t.string :msg_type
      t.string :music_url
      t.string :hq_music_url
      t.string :func_flag
      t.string :content

      t.timestamps
    end
  end
end
