class CreateMessageKeywords < ActiveRecord::Migration
  def change
    create_table :message_keywords do |t|
      t.string :content

      t.timestamps
    end
  end
end
