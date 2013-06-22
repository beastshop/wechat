require 'json'
class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source

	def call
		render :text => params[:echostr]
		unless params[:xml].nil?
			
		end
	end

	private

	def verify_request_source
		array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
		render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
	end

end
