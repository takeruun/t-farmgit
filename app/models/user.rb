class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
    	     :recoverable, :rememberable, :validatable
	validates :name,{presence: true}
	validates :email,{presence: true, uniqueness: true}
	validates :password,{presence: true}
	validates :image_name,{presence: true}

	has_many :posts, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :fav_posts, through: :favorite, source: :post

end
