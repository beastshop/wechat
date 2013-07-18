class MessageReceivesController < ApplicationController
  before_filter :authenticate_user!
  def index
  	 @message_receives = MessageReceive.page(params[:page]).per(20)
  end
  
end