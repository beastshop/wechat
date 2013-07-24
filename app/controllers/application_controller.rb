class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
      "/message_keywords" # <- Path you want to redirect the user to.
  end

   def after_sign_out_path_for(resource)
      "/users/sign_in" # <- Path you want to redirect the user to.
  end

  protected

  def layout_by_resource
    if devise_controller?
      "signin_layout"
    else
      "application"
    end
  end
end
