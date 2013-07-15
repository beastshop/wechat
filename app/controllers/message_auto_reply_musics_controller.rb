class MessageAutoReplyMusicsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @message_auto_reply_musics = MessageAutoReplyMusic.all
  end

  def show
    @message_auto_reply_music = MessageAutoReplyMusic.find(params[:id])
  end

  def new
    @message_auto_reply_music = MessageAutoReplyMusic.new
    @keywords = MessageKeyword.all
  end

  def edit
    @message_auto_reply_music = MessageAutoReplyMusic.find(params[:id])
    @keywords = MessageKeyword.all
  end

  def create
    @message_auto_reply_music = MessageAutoReplyMusic.new(params[:message_auto_reply_music])

    unless params[:keywords].nil?
      params[:keywords].each do |kid|
        @message_auto_reply_music.message_keywords << MessageKeyword.find(kid)
      end
    end
    

    if @message_auto_reply_music.save
      redirect_to @message_auto_reply_music
    else
      render action: "new"
    end
    
  end

  def update
    @message_auto_reply_music = MessageAutoReplyMusic.find(params[:id])


    MessageKeyword.all.each do |mk|
      if params[:keywords].include?(mk.id.to_s) && !@message_auto_reply_music.message_keywords.pluck(:id).include?(mk.id)
        @message_auto_reply_music.message_keywords << mk
      end

      if !params[:keywords].include?(mk.id.to_s) && @message_auto_reply_music.message_keywords.pluck(:id).include?(mk.id)
        @message_auto_reply_music.message_keywords.delete(mk)
      end
    end

    if @message_auto_reply_music.update_attributes(params[:message_auto_reply_music])
      redirect_to @message_auto_reply_music
    else
      render action: "edit"
    end
    
  end

  def destroy
    @message_auto_reply_music = MessageAutoReplyMusic.find(params[:id])
    @message_auto_reply_music.destroy

    redirect_to message_auto_reply_musics_url 
    
  end
end
