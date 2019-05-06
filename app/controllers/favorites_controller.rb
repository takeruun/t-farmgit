class FavoritesController < ApplicationController
	before_action :ser_variables

	def create
		@favorite = current_user.favorites.create(post_id: @post.id)
	end

	def destroy
		@favorite = current_user.favorites.find_by(post_id: @post.id)
		@favorite.destroy
	end

	def ser_variables
		@post = Post.find(params[:post_id])
		
	end

end
