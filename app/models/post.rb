class Post < ApplicationRecord
	validates :user_id,{presence: true}
	validates :post_image,{presence: true}
	
	mount_uploader :post_image, ImgUploader

	def user
		return User.find_by(id: self.user_id)
	end
end
