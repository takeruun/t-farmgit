class PostsController < ApplicationController

  def index
    @recpost = Post.find_by(rec: true)
    respond_to do |format|
      format.html
      format.json { @new_recpost = Post.where('id >= ? and rec = ?', params[:recpost][:id], true)}
    end
    @posts = Post.order(created_at: :desc).limit(9)
  end

  def new
    @post = Post.new
  end

  def create
  	 @post = Post.new(post_params)
     @post.rec = true
     @post.user_id =  current_user.id

    if  params[:post][:post_image] && @post.save
        @post.image_name = "#{@post.id}.jpg"
        File.binwrite("public/post_images/#{@post.image_name}",params[:post][:post_image].read)
        @post.save
        redirect_to('/')
    elsif 
        flash[:notice] = @post.errors.full_messages
        render('/posts/new')
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  def edit
   @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find(id: params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集しました"
      redirect_to("posts/#{@post.id}")
    else
      render('post/edit')
    end

  end

  private
  def post_params
    params.require(:post).permit(:comment,:title,:amount,:from)
  end
end
