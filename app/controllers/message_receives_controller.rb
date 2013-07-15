class MessageReceivesController < ApplicationController
  before_filter :authenticate_user!
  def index
  	 @message_receives = MessageReceive.all
  end
  
end