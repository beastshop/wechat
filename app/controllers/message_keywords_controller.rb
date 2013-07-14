# encoding: utf-8
class MessageKeywordsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @message_keywords = MessageKeyword.all

  end

  def show
    @message_keyword = MessageKeyword.find(params[:id])
  end

  def new
    @message_keyword = MessageKeyword.new
    @auto_texts = MessageAutoReplyText.all
    @auto_musics = MessageAutoReplyMusic.all
    @auto_news = MessageAutoReplyNews.all
  end

  def edit
    @message_keyword = MessageKeyword.find(params[:id])
    @auto_texts = MessageAutoReplyText.all
    @auto_musics = MessageAutoReplyMusic.all
    @auto_news = MessageAutoReplyNews.all
  end

  def create
    @message_keyword = MessageKeyword.new(params[:message_keyword])
    if !params[:auto_id].nil?
      case params[:auto_type]
      when "text"
        @message_keyword.message_auto_reply_texts << MessageAutoReplyText.find(params[:auto_id])
      when "voice"
        @message_keyword.message_auto_reply_musics << MessageAutoReplyMusic.find(params[:auto_id])
      when "news"
        @message_keyword.message_auto_reply_news << MessageAutoReplyNews.find(params[:auto_id])
      end
    end

    if @message_keyword.save
      redirect_to message_keywords_url
    else
      render action: "new" 
    end
  end

  def update
    @message_keyword = MessageKeyword.find(params[:id])

    @message_keyword.message_auto_reply_texts.clear
    @message_keyword.message_auto_reply_musics.clear
    @message_keyword.message_auto_reply_news.clear
    if !params[:auto_id].nil?
      case params[:auto_type]
      when "text"
        @message_keyword.message_auto_reply_texts << MessageAutoReplyText.find(params[:auto_id])
      when "voice"
        @message_keyword.message_auto_reply_musics << MessageAutoReplyMusic.find(params[:auto_id])
      when "news"
        @message_keyword.message_auto_reply_news << MessageAutoReplyNews.find(params[:auto_id])
      end
    end

    if @message_keyword.update_attributes(params[:message_keyword])
      redirect_to message_keywords_url
    else
      render action: "edit" 
    end
  end

  def destroy
    @message_keyword = MessageKeyword.find(params[:id])
    @message_keyword.destroy

    redirect_to message_keywords_url
  end
end
