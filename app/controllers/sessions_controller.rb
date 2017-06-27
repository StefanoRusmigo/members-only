class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:session][:email])
  	if @user && @user.authenticate(params[:session][:password])
  	  login @user

  	  params[:session][:remember] == '1'? remember(@user) : forget(@user)
  	
  	  flash[:success] = "Succesful login"
      redirect_to @user
  	else
  		flash[:fail] = "Wrong credentials"
  		render 'new'
  	end
  end

  def destroy
  	forget current_user
  	session[:user_id] = nil
  	redirect_to users_path
  end


end
