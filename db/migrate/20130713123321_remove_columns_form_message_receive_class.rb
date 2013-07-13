class RemoveColumnsFormMessageReceiveClass < ActiveRecord::Migration
	def change
		remove_column :message_receive_texts, :from_user_name, :to_user_name, :msg_id, :create_time, :msg_type
		remove_column :message_receive_images, :from_user_name, :to_user_name, :msg_id, :create_time, :msg_type
		remove_column :message_receive_locations, :from_user_name, :to_user_name, :msg_id, :create_time, :msg_type
		remove_column :message_receive_links, :from_user_name, :to_user_name, :msg_id, :create_time, :msg_type
		remove_column :message_receive_events, :from_user_name, :to_user_name, :create_time, :msg_type
		remove_column :message_receive_voices, :from_user_name, :to_user_name, :msg_id, :create_time, :msg_type
	end
end
