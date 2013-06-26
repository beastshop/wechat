class AddAttachmentToMessageAutoReplyNewsArticle < ActiveRecord::Migration
  def change
  	add_column :message_auto_reply_news_articles, :pic_url_file_name, :string
    add_column :message_auto_reply_news_articles, :pic_url_content_type, :string
    add_column :message_auto_reply_news_articles, :pic_url_file_size, :integer
  end
end
