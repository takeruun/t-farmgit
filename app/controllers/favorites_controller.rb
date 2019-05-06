class FavoritesController < ApplicationController
	before_action :ser_variables

	def create
		@favorite = current_user.favorites.create(post_id: @post.id)
		render 'fav.js.erb'	
	end

	def destroy
		@favorite = current_user.favorites.find_by(post_id: @post.id)
		@favorite.destroy
		render 'fav.js.erb'
	end

	def ser_variables
		@post = Post.find(params[:post_id])
		@id_name = "#link-favorite-#{@post.id}"
	end

end
