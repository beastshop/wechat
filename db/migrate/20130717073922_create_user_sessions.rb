class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.string :open_id
      t.string :order_no
      t.string :status
      t.boolean :is_timeout
      t.datetime :entry_at
      t.belongs_to :user
      t.timestamps
    end
  end
end
