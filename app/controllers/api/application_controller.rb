class Api::ApplicationController < ActionController::Base
  	protect_from_forgery
	skip_before_filter :verify_authenticity_token
	before_filter :verify_request_source

	private
	def verify_request_source
		array = [Rails.configuration.wechat_token, params[:timestamp], params[:nonce]].sort
		render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
	end

end
