class UsersController < ApplicationController
	before_action :is_logged_in_as_admin?, only: [:destroy,:member,:edit]



	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			@user.mk_admin if params[:user][:admin] == '1'
			login @user
			flash[:success] = "User has been created"
			redirect_to @user
		else
			render 'new'
		end
	end

	def index
		@users = User.all
	end

	def show
	  @user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if  @user.update_attributes(user_params)
			@user.mk_admin if params[:user][:admin] == '1'
			flash[:success] = "User has been updated"
			redirect_to @user
		else
			render 'edit'
		end

	end

	def destroy
		@user.delete
		flash[:success] = "User has been deleted"
		redirect_to users_path

	end

	def member 
		user = User.find(params[:user])
		user.update_attribute(:member,:true)
		redirect_to users_path
	end


	private

	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation)
	end

	def is_logged_in_as_admin?
		unless is_logged_in? && current_user.admin
			flash[:fail] = "NOt ALLOWED"
			redirect_to users_path
		end
	end
end
