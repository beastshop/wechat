class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
      "/message_keywords" # <- Path you want to redirect the user to.
  end
end
