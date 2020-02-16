class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :a_word, presence: true
  validates :title, presence: true
  validates :image, presence: true

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader

  def user
    User.find_by(id: user_id)
  end

  def favorited_by?(user)
    favorites.find_by(user_id: user.id)
  end
end
