class RenameLinkTables < ActiveRecord::Migration
  def up
    create_table :message_auto_reply_texts_message_keywords, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_text_id
    end
    create_table :message_auto_reply_musics_message_keywords, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_music_id
    end

    drop_table :message_keywords_message_auto_reply_musics
    drop_table :message_keywords_message_auto_reply_texts
  end

  def down
    create_table :message_keywords_message_auto_reply_musics, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_music_id
    end
    create_table :message_keywords_message_auto_reply_texts, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_text_id
    end

    drop_table :message_auto_reply_texts_message_keywords
    drop_table :message_auto_reply_musics_message_keywords
  end
end
