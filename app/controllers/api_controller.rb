require 'json'
class ApiController < ApplicationController
  layout nil
  
  def auth
    respond_to do |format|
      format.html { render json: params[:echostr] }
    end
  end
  
end
