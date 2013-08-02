class AddTitleToAutoReplyMusics < ActiveRecord::Migration
  def change
  	add_column :message_send_musics, :title, :string
  	add_column :message_send_musics, :description, :string
  	add_column :message_auto_reply_musics, :title, :string
  	add_column :message_auto_reply_musics, :description, :string
  end
end
