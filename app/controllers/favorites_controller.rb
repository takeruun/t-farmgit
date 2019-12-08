class FavoritesController < ApplicationController
	before_action :set_post
	before_action :authenticate_user!, {only: [:create, :destroy]}

	def create
		@favorite = current_user.favorites.create(post_id: @post.id)
		@post.fav_count = @post.favorites.count
		@post.save
	end

	def destroy
		@favorite = current_user.favorites.find_by(post_id: @post.id)
		@favorite.destroy
		@post.fav_count = @post.favorites.count
		@post.save
	end

	private
	def set_post
		@post = Post.find(params[:post_id])
	end

end
