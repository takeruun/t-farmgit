class HomeController < ApplicationController
  
  def top
  	@recpost = Post.find_by(id:1)
  	@posts = Post.order(created_at: :desc).limit(9)
  end

end
