class Post < ApplicationRecord
	validates :user_id,{presence: true}
	validates :comment,{presence: true}
	validates :title,{presence: true}
	validates :image,{presence: true}
	
	has_many :favorites, dependent: :destroy
	has_many :users, through: :favorites

	mount_uploader :image, ImageUploader

	def user
		return User.find_by(id: self.user_id)
	end

	def favorited_by?(user)
		favorites.find_by(user_id: user.id)
	end

end
