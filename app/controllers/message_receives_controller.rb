class MessageReceivesController < ApplicationController
  before_filter :authenticate_user!
  def index
  	 @message_receive_events = MessageReceiveEvent.order("id desc")
  	 @message_receive_images = MessageReceiveImage.order("id desc")
  	 @message_receive_texts = MessageReceiveText.order("id desc")
  	 @message_receive_voices = MessageReceiveVoice.order("id desc")
  	 @message_receive_locations = MessageReceiveLocation.order("id desc")
  	 @message_receive_links = MessageReceiveLink.order("id desc")
  end
  
end