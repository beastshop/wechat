# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130626080842) do

  create_table "message_auto_reply_musics", :force => true do |t|
    t.string   "music_url"
    t.string   "hq_music_url"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "music_url_file_name"
    t.string   "music_url_content_type"
    t.integer  "music_url_file_size"
    t.string   "hq_music_url_file_name"
    t.string   "hq_music_url_content_type"
    t.integer  "hq_music_url_file_size"
  end

  create_table "message_auto_reply_texts", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_keywords", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_keywords_message_auto_reply_musics", :id => false, :force => true do |t|
    t.integer "message_keyword_id"
    t.integer "message_auto_reply_music_id"
  end

  create_table "message_keywords_message_auto_reply_texts", :id => false, :force => true do |t|
    t.integer "message_keyword_id"
    t.integer "message_auto_reply_text_id"
  end

  create_table "message_receive_events", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.string   "event"
    t.string   "event_key"
    t.text     "origin_source"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "message_receive_images", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.string   "pic_url"
    t.integer  "msg_id",         :limit => 8
    t.text     "origin_source"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "message_receive_links", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.integer  "msg_id",         :limit => 8
    t.text     "origin_source"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "message_receive_locations", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.decimal  "location_x",                  :precision => 10, :scale => 0
    t.decimal  "location_y",                  :precision => 10, :scale => 0
    t.integer  "scale"
    t.string   "label"
    t.integer  "msg_id",         :limit => 8
    t.text     "origin_source"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "message_receive_texts", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.text     "content"
    t.integer  "msg_id",         :limit => 8
    t.text     "origin_source"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "message_receive_voices", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.string   "media_id"
    t.string   "format"
    t.integer  "msg_id",         :limit => 8
    t.string   "recognition"
    t.text     "region_source"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "message_send_musics", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.string   "music_url"
    t.string   "hq_music_url"
    t.string   "func_flag"
    t.string   "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "message_send_news", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.integer  "article_count"
    t.string   "func_flag"
    t.string   "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "message_send_news_articles", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "pic_url"
    t.integer  "message_send_news_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "message_send_texts", :force => true do |t|
    t.string   "to_user_name"
    t.string   "from_user_name"
    t.datetime "create_time"
    t.string   "msg_type"
    t.integer  "msg_id",         :limit => 8
    t.string   "func_flag"
    t.string   "content"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
