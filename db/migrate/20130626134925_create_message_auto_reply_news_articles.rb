class CreateMessageAutoReplyNewsArticles < ActiveRecord::Migration
  def change
    create_table :message_auto_reply_news_articles do |t|
      t.string :title
      t.string :description
      t.string :pic_url
      t.integer :message_auto_reply_news_id

      t.timestamps
    end
  end
end
