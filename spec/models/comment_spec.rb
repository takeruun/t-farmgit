require 'rails_helper'

RSpec.describe Comment, type: :model do
	let(:user){build(:user)}
	let(:post){build(:post)}

	it "コメントできる" do
		@comment = build(:comment, user: user, post: post)
		expect(@comment).to be_valid
	end

	it "ユーザ無しだと無効" do 
		@comment = build(:comment, post: post)
		@comment.valid?
		expect(@comment.errors[:user]).to include("を入力してください")
	end

	it "投稿無しだと無効" do 
		@comment = build(:comment, user: user)
		@comment.valid?
		expect(@comment.errors[:post]).to include("を入力してください")
	end


end
