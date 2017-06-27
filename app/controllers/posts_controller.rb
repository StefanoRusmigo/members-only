class PostsController < ApplicationController
  before_actoion :is_logged_in?, only:[:new, :create]
  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user = current_user
  	if @post.save
  		flash[:success] = "You have create a new post"
  		redirect_to posts_url
  	else
  		render 'new'
    end
  end

  def index
  	@posts = Post.all
  end



  private

  def post_params
  	params.require(:post).permit(:title,:body)
  end
end
