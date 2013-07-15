class MessageAutoReplyNewsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @message_auto_reply_news = MessageAutoReplyNews.all

  end

  def show
    @message_auto_reply_news = MessageAutoReplyNews.find(params[:id])
    @articles = @message_auto_reply_news.message_auto_reply_news_articles
    p @articles
  end

  def new
    @message_auto_reply_news = MessageAutoReplyNews.new
    @keywords = MessageKeyword.all
  end

  def edit
    @message_auto_reply_news = MessageAutoReplyNews.find(params[:id])
    @keywords = MessageKeyword.all
  end

  def create
    @message_auto_reply_news = MessageAutoReplyNews.new(params[:message_auto_reply_news])

    unless params[:keywords].nil?
      params[:keywords].each do |kid|
        @message_auto_reply_news.message_keywords << MessageKeyword.find(kid)
      end
    end
    

    if @message_auto_reply_news.save
      redirect_to @message_auto_reply_news
    else
      render action: "new"
    end
    
  end

  def update
    @message_auto_reply_news = MessageAutoReplyNews.find(params[:id])


    MessageKeyword.all.each do |mk|
      if params[:keywords].include?(mk.id.to_s) && !@message_auto_reply_news.message_keywords.pluck(:id).include?(mk.id)
        @message_auto_reply_news.message_keywords << mk
      end

      if !params[:keywords].include?(mk.id.to_s) && @message_auto_reply_news.message_keywords.pluck(:id).include?(mk.id)
        @message_auto_reply_news.message_keywords.delete(mk)
      end
    end

    if @message_auto_reply_news.update_attributes(params[:message_auto_reply_news])
      redirect_to @message_auto_reply_news
    else
      render action: "edit"
    end
    
  end

  def destroy
    @message_auto_reply_news = MessageAutoReplyNews.find(params[:id])
    @message_auto_reply_news.destroy

    render :text => "{}"  
    
  end
end
