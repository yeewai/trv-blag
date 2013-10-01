class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    @current_user ||=User.find_by_token!(cookies[:user_token]) if cookies[:user_token]
  end
  helper_method :current_user
  
  def authorize
    render :template => "sessions/admin" if !current_user
  end
end
