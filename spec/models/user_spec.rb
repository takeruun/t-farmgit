require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let(:user1) { build(:user) }

  it 'ユーザー作成できる' do
    expect(user).to be_valid
  end

  it '名前がないと作成できない' do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it 'パスワードがないと作成できない' do
    user.password = ''
    user.valid?
    expect(user.errors[:password]).to include('を入力してください')
  end

  it 'パスワードが6文字以上じゃないと作成できない' do
    user.password = 'Tt'
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it 'メアド重複すると作成できない' do
    user1.email = 'a@example.com'
    user1.valid?
    expect(user1.errors[:email]).to include('はすでに存在します')
  end
end
