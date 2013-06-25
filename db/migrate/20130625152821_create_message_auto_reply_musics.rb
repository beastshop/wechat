class CreateMessageAutoReplyMusics < ActiveRecord::Migration
  def change
    create_table :message_auto_reply_musics do |t|
      t.string :music_url
      t.string :hq_music_url

      t.timestamps
    end

    create_table :message_keywords_message_auto_reply_musics, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_music_id
    end
  end
end
