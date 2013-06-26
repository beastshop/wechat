# encoding: utf-8
class MessageKeywordsController < ApplicationController
  def index
    @message_keywords = MessageKeyword.all
  end

  def show
    @message_keyword = MessageKeyword.find(params[:id])
  end

  def new
    @message_keyword = MessageKeyword.new
  end

  def edit
    @message_keyword = MessageKeyword.find(params[:id])
  end

  def create
    @message_keyword = MessageKeyword.new(params[:message_keyword])

    if @message_keyword.save
      redirect_to @message_keyword
    else
      render action: "new" 
    end
  end

  def update
    @message_keyword = MessageKeyword.find(params[:id])

    if @message_keyword.update_attributes(params[:message_keyword])
      redirect_to @message_keyword
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
