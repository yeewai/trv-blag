class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    @current_user ||=User.find_by_token!(cookies[:user_token]) if cookies[:user_token]
  end
  helper_method :current_user
  
  def authorize
    render :template => "sessions/admin" if !current_user
  end
  
  def post_gmap
    Post.all.to_gmaps4rails do |post, marker|
      marker.infowindow render_to_string(:partial => "/layouts/marker", :locals => { :post => post})\
      #marker.picture({
      #                :picture => "http://www.blankdots.com/img/github-32x32.png",
      #                :width   => 32,
      #                :height  => 32
      #               })
      marker.title   "i'm the title"
      marker.sidebar "i'm the sidebar"
      marker.json({ :id => post.id, :foo => "bar" })
    end
  end
  helper_method :post_gmap
end
