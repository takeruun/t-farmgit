class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, {presence: true}
  validates :image, {presence: true}

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_posts, through: :favorite, source: :post

  mount_uploader :image, ImageUploader
  
end
