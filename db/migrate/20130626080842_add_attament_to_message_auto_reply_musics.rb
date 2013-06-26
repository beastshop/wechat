class AddAttamentToMessageAutoReplyMusics < ActiveRecord::Migration
  def change
  	add_column :message_auto_reply_musics, :music_url_file_name, :string
    add_column :message_auto_reply_musics, :music_url_content_type, :string
    add_column :message_auto_reply_musics, :music_url_file_size, :integer

    add_column :message_auto_reply_musics, :hq_music_url_file_name, :string
    add_column :message_auto_reply_musics, :hq_music_url_content_type, :string
    add_column :message_auto_reply_musics, :hq_music_url_file_size, :integer
  end
end
