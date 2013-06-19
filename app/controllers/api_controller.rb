require 'json'
class ApiController < ApplicationController
  layout nil
  
  def wechat
    respond_to do |format|
      format.html { render json: params[:echostr] }
    end
  end
  
end
