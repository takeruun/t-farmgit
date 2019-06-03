require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
  	@post=Post.create(
  		user_id: 2,
  		image_name: "1.jpg",
  		comment: "exampleですよ",
  		rec: true
  		)
  end

  it "投稿できる" do
  	expect(@post).to be_valid
  end

  it "ユーザーIDがない" do
  	post=Post.new(user_id: nil)
  	post.valid?
  	expect(post.errors[:user_id]).to include("を入力してください")
  end

  it "画像無しだと投稿できない" do
  	post=Post.new(image_name: nil)
  	post.valid?
  	expect(post.errors[:image_name]).to include("を入力してください")
  end

  it "コメント" do
  	post=Post.new(comment: nil)
  	post.valid?
  	expect(post.errors[:comment]).to include("を入力してください")
  end
end
