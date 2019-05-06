class FavoritesController < ApplicationController
	before_action :ser_post

	def create
		@favorite = current_user.favorites.create(post_id: @post.id)
	end

	def destroy
		@favorite = current_user.favorites.find_by(post_id: @post.id)
		@favorite.destroy
	end

	private
	def ser_post
		@post = Post.find(params[:post_id])
	end

end
