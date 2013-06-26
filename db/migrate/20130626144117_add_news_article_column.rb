class AddNewsArticleColumn < ActiveRecord::Migration
  def change
	add_column :message_auto_reply_news_articles, :url, :string
	add_column :message_send_news_articles, :url, :string
  end
end
