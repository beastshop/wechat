class WechatUsersController < ApplicationController
	def index
		@wechat_users = params[:subscribe].nil? ? WechatUser.page(params[:page]).per(20) : WechatUser.where("is_subscribe = #{params[:subscribe]=='true' ? 1 : 0}").page(params[:page]).per(20)

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
