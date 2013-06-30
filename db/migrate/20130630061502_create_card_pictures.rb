class CreateCardPictures < ActiveRecord::Migration
  def change
    create_table :card_pictures do |t|
      t.string :order_no
      t.string :wechat_user_open_id
      t.string :title
      t.integer :card_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size

      t.timestamps
    end
  end
end
