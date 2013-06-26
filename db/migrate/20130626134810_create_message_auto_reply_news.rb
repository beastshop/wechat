class CreateMessageAutoReplyNews < ActiveRecord::Migration
  def change
    create_table :message_auto_reply_news do |t|
      t.integer :article_count
      t.string :content

      t.timestamps
    end

    create_table :message_auto_reply_news_message_keywords, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_news_id
    end
  end
end
