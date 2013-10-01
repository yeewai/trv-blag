class SessionsController < ApplicationController
  def login
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:pass] ) 
      cookies.permanent[:user_token] = {:value => user.token}
      
      redirect_to root_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "login"
    end
  end
  
  def logout
    cookies.delete :user_token
    redirect_to root_url
  end
end
