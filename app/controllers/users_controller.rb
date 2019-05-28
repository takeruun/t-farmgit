class UsersController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def favorites
  	@user = User.find(params[:id])
  	@favorites = @user.favorites
  end

end