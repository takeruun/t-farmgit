require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザー作成できる" do
  	user=User.new(
  		name: "パッポー",
  		image_name: "example.jpg",
  		email: "pa@example.com",
  		password: "akeebUen"
  		)
  	expect(user).to be_valid
  end

  it "名前ちゃんとある" do
  	user=User.new(name:nil)
  	user.valid?
  	expect(user.errors[:name]).to_not include("can't be blank")
  end

  it "写真の名前ちゃんとある" do
  	user=User.new(image_name:nil)
  	user.valid?
  	expect(user.errors[:image_name]).to_not include("can't be blank")
  end

  it "メアド重複しない" do
  	User.create(
  		name: "パッポー",
  		image_name: "example.jpg",
  		email: "pa@example.com",
  		password: "akeebUen"
  		)
  	user=User.new(
  		name: "ari",
  		image_name: "example.jpg",
  		email: "pa@example.com",
  		password: "akeebUen"
  		)
  	user.valid?
  	expect(user.errors[:email]).to_not include("has alredy been taken")
  end

end
