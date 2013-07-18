class MessageAutoReplyNewsArticlesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @message_auto_reply_news_articles = MessageAutoReplyNewsArticle.page(params[:page]).per(20)

  end

  def show
    @message_auto_reply_news_article = MessageAutoReplyNewsArticle.find(params[:id])
  end

  def new
    @message_auto_reply_news_article = MessageAutoReplyNewsArticle.new
    @keywords = MessageAutoReplyNews.all
  end

  def edit
    @message_auto_reply_news_article = MessageAutoReplyNewsArticle.find(params[:id])
    @keywords = MessageAutoReplyNews.all
  end

  def create
    @message_auto_reply_news_article = MessageAutoReplyNewsArticle.new(params[:message_auto_reply_news_article])

   
    if @message_auto_reply_news_article.save
      redirect_to @message_auto_reply_news_article
    else
      render action: "new"
    end
    
  end

  def update
    @message_auto_reply_news_article = MessageAutoReplyNewsArticle.find(params[:id])


	

    if @message_auto_reply_news_article.update_attributes(params[:message_auto_reply_news_article])
      redirect_to @message_auto_reply_news_article
    else
      render action: "edit"
    end
    
  end

  def destroy
    @message_auto_reply_news_article = MessageAutoReplyNewsArticle.find(params[:id])
    @message_auto_reply_news_article.destroy

    redirect_to message_auto_reply_news_articles_url 
    
  end
end
