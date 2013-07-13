class RemoveColumnsFromMessageSendClass < ActiveRecord::Migration
	def change
		remove_column :message_send_texts, :from_user_name, :to_user_name, :create_time, :func_flag, :msg_type, :msg_id
		remove_column :message_send_musics, :from_user_name, :to_user_name, :create_time, :func_flag, :msg_type
		remove_column :message_send_news, :from_user_name, :to_user_name, :create_time, :func_flag, :msg_type

		add_column :message_send_texts, :message_send_id, :integer
		add_column :message_send_news, :message_send_id, :integer
		add_column :message_send_musics, :message_send_id, :integer
	end
end
