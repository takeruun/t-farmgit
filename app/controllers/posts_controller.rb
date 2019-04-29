class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
  	 @post = Post.new(
      comment: params[:post][:comment],
      user_id: @current_user.id
      )
     @post.save
     
    if params[:post][:post_image]
        @post.image_name = "#{@post.id}.jpg"
        File.binwrite("public/post_images/#{@post.image_name}",params[:post][:post_image].read)
        @post.save
        redirect_to('/')
    else
        flash[:notice] = "写真を登録してください"
        render('/posts/new')
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
end
