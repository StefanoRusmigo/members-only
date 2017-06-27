class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login user
  	session[:user_id] = user.id
  end

  def is_logged_in?
  	if session[:user_id]  || remember_option
  		return true
  	end
  end

   def current_user
      user = User.find_by(id: session[:user_id])
   end

   def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember] = user.remember_token
   end

   def forget user 
    cookies.delete(:user_id)
    cookies.delete(:remember)
   end


   def remember_option
    user =  User.find_by(id:cookies.signed[:user_id])
    if  user && user.authenticate?(cookies.signed[:remember])
      session[:user_id] = user.id
    end
   end

  helper_method :is_logged_in?, :current_user

end
