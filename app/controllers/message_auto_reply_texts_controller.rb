class MessageAutoReplyTextsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @message_auto_reply_texts = MessageAutoReplyText.page(params[:page]).per(20)

  end

  def new_model
    @message_auto_reply_text = MessageAutoReplyText.new
    @message_auto_reply_text.content = params[:content]
    @message_auto_reply_text.save
    render :text => @message_auto_reply_text.id.to_s
  end

  def show
    @message_auto_reply_text = MessageAutoReplyText.find(params[:id])
  end

  def new
    @message_auto_reply_text = MessageAutoReplyText.new
    @keywords = MessageKeyword.all
  end

  def edit
    @message_auto_reply_text = MessageAutoReplyText.find(params[:id])
    @keywords = MessageKeyword.all
  end

  def create
    @message_auto_reply_text = MessageAutoReplyText.new(params[:message_auto_reply_text])

    params[:keywords].each do |kid|
      @message_auto_reply_text.message_keywords << MessageKeyword.find(kid)
    end

    if @message_auto_reply_text.save
      redirect_to @message_auto_reply_text
    else
      render action: "new"
    end
    
  end

  def update
    @message_auto_reply_text = MessageAutoReplyText.find(params[:id])


    MessageKeyword.all.each do |mk|
      if params[:keywords].include?(mk.id.to_s) && !@message_auto_reply_text.message_keywords.pluck(:id).include?(mk.id)
        @message_auto_reply_text.message_keywords << mk
      end

      if !params[:keywords].include?(mk.id.to_s) && @message_auto_reply_text.message_keywords.pluck(:id).include?(mk.id)
        @message_auto_reply_text.message_keywords.delete(mk)
      end
    end

    if @message_auto_reply_text.update_attributes(params[:message_auto_reply_text])
      redirect_to @message_auto_reply_text
    else
      render action: "edit"
    end
    
  end

  def destroy
    @message_auto_reply_text = MessageAutoReplyText.find(params[:id])
    @message_auto_reply_text.destroy
    render :text => "{}"    
  end
end
