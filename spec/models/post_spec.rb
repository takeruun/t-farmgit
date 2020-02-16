require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { create(:user) }
  let(:post) { build(:post, user_id: user.id) }

  it '投稿できる' do
    expect(post).to be_valid
  end

  it 'ユーザ無しだと無効' do
    @post = build(:post)
    @post.valid?
    expect(@post.errors[:user_id]).to include('を入力してください')
  end

  it 'コメントがないと投稿できない' do
    post.a_word = nil
    post.valid?
    expect(post.errors[:a_word]).to include('を入力してください')
  end

  it 'タイトルがないと投稿できない' do
    post.title = nil
    post.valid?
    expect(post.errors[:title]).to include('を入力してください')
  end

  it '写真がないと投稿できない' do
    post.image = nil
    post.valid?
    expect(post.errors[:image]).to include('を入力してください')
  end
end
