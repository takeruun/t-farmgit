require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "ユーザー作成できる" do
  	user = build(:user)
  	expect(user).to be_valid
  end

  it "名前ちゃんとある" do
  	user = build(:user, name: nil)
  	user.valid?
  	expect(user.errors[:name]).to include("を入力してください")

  end

  it "写真の名前ちゃんとある" do
  	user = build(:user,image_name: nil)
  	user.valid?
  	expect(user.errors[:image_name]).to include("を入力してください")
  end

  it "メアド重複しない" do
  	user1 = build(:user1)
  	user1.valid?
  	expect(user1.errors[:email]).to include("はすでに存在します")
  end

end
