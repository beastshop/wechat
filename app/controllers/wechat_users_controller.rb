class WechatUsersController < ApplicationController
	def index
		@wechat_users = WechatUser.page(params[:page]).per(20)
	end

	def edit
		@wechat_user = WechatUser.find(params[:id])
	end

	def update
    	@wechat_user = WechatUser.find(params[:id])

		if @wechat_user.update_attributes(params[:wechat_user])
	      redirect_to wechat_users_url
	    else
	      render action: "edit" 
	    end
	end
end
