class RenameColumnToMessageReceiveAndMessageSend < ActiveRecord::Migration
	def change
		rename_column :message_receives, :ceate_time, :create_time
		rename_column :message_sends, :ceate_time, :create_time
	end
end
