class HomeController < ApplicationController
  
  def top
  	@recpost = Post.find_by(rec: true)
  	respond_to do |format|
  		format.html
  		format.json { @new_recpost = Post.where('id >= ? and rec = ?', params[:recpost][:id], true)}
  	end
  	@posts = Post.order(created_at: :desc).limit(9)
  end

end
