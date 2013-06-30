class CreateCardVoices < ActiveRecord::Migration
  def change
    create_table :card_voices do |t|
      t.string :order_no
      t.string :wechat_user_open_id
      t.integer :card_id
      t.string :sound_file_name
      t.string :sound_content_type
      t.integer :sound_file_size
      t.timestamps
    end
  end
end
