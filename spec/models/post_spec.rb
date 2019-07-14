require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:post){create(:post)}

  it "投稿できる" do
  	expect(post).to be_valid
  end

  it "ユーザーIDがないと投稿できない" do
  	post.user_id = nil
  	post.valid?
  	expect(post.errors[:user_id]).to include("を入力してください")
  end

  it "コメントがないと投稿できない" do
  	post.comment = nil
  	post.valid?
  	expect(post.errors[:comment]).to include("を入力してください")
  end

  it "タイトルがないと投稿できない" do
    post.title = nil
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end

end
