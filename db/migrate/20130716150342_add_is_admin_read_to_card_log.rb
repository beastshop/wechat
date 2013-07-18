class AddIsAdminReadToCardLog < ActiveRecord::Migration
  def change
  	add_column :card_logs, :is_admin_read, :boolean
  end
end
