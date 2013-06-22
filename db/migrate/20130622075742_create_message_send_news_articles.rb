class CreateMessageSendNewsArticles < ActiveRecord::Migration
  def change
    create_table :message_send_news_articles do |t|
      t.string :title
      t.string :description
      t.string :pic_url
      t.integer :message_send_news_id

      t.timestamps
    end
  end
end
