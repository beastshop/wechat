class CreateMessageAutoReplyTexts < ActiveRecord::Migration
  def change
    create_table :message_auto_reply_texts do |t|
      t.string :content

      t.timestamps
    end

    create_table :message_keywords_message_auto_reply_texts, :id => false do |t|
      t.integer :message_keyword_id
      t.integer :message_auto_reply_text_id
    end
  end
end
