class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @favpost = Post.order(fav_count: :desc).where('fav_count > ?', 0).limit(4).last
    if @favpost
      respond_to do |format|
        format.html
        format.json { @new_favpost = Post.order(fav_count: :desc).where('fav_count > ?', 0).limit(4) }
      end
    end
    @posts = Post.order(created_at: :desc).limit(9)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to('/posts')
    else
      flash[:notice] = @post.errors.full_messages
      render('/posts/new')
    end
  end

  def show
    @post = Post.find_by(params[:id])
    @user = @post.user
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find_by(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '編集しました'
      redirect_to("/posts/#{@post.id}")
    else
      flash[:notice] = @post.errors.full_messages
      render('/posts/edit')
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to('/posts')
  end

  private

  def post_params
    params.require(:post).permit(:comment, :title, :image, :amount, :from)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      flash[:notice] = '権限がありません'
      redirect_to('/posts')
    end
  end
end
