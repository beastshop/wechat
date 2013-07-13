class MessageReceivesController < ApplicationController
  before_filter :authenticate_user!
  def index
  	 @message_receive_events = MessageReceiveEvent.all
  	 @message_receive_images = MessageReceiveImage.all
  	 @message_receive_texts = MessageReceiveText.all
  	 @message_receive_voices = MessageReceiveVoice.all
  	 @message_receive_locations = MessageReceiveLocation.all
  	 @message_receive_links = MessageReceiveLink.all
  end
  
end