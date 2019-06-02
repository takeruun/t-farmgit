require 'rails_helper'

RSpec.describe User, type: :model do
  before do
  	@user=User.create(
  		name: "パッポー",
  		image_name: "example.jpg",
  		email: "pa@example.com",
  		password: "akeebUen"
  		)
  end

  it "ユーザー作成できる" do
  	expect(@user).to be_valid
  end

  it "名前ちゃんとある" do
  	user=User.new(name: nil)
  	user.valid?
  	expect(user.errors[:name]).to include("を入力してください")

  end

  it "写真の名前ちゃんとある" do
  	user=User.new(image_name: nil)
  	user.valid?
  	expect(user.errors[:image_name]).to include("を入力してください")
  end

  it "メアド重複しない" do
  	user=User.new(
  		name: "ari",
  		image_name: "example.jpg",
  		email: "pa@example.com",
  		password: "akeebUen"
  		)
  	user.valid?
  	expect(user.errors[:email]).to include("はすでに存在します")
  end

end
