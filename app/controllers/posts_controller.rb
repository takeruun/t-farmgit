class PostsController < ApplicationController

  def new
    @post=Post.new()
  end

  def create
  	 @post = Post.new(permit_params)
     @post.user_id = @current_user.id
    if params[:image]
        @post.save
        redirect_to('/')
    else
        flash[:notice] = "写真を登録してください"
        render('/posts/new')
    end
  end

  private
    def permit_params
      params.require(:post).permit(:comment,:image)
    end

end
