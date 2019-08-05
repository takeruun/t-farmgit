require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user){create(:user)}
  let(:other_user){create(:other_user)}

  it "ユーザー作成できる" do
  	expect(user).to be_valid
  end

  it "名前がないと有効でない" do
  	user.name = nil
  	user.valid?
  	expect(user.errors[:name]).to include("を入力してください")
  end

  it "パスワードがないと有効でない" do
    user.password = ""
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが6文字以上じゃないと有効でない" do
    user.password = "Tt"
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "メアド重複すると有効でない" do
    other_user.email = user.email
    other_user.valid?
    expect(other_user.errors[:email]).to include("はすでに存在します")
  end

end
