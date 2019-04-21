class HomeController < ApplicationController
  
  def top
  	@recpost = Post.find_by(id:1)
  	@posts = Post.all.order(created_at: :desc)
  end

end
