require 'rails_helper'

RSpec.describe "Uesr", type: :systen do
	let(:user){build(:user)}

	it "ユーザーログインできるか" do
		visit new_user_session_path
		fill_in "メールアドレス", with: user.email
		fill_in "パスワード", with: user.password
		click_button 'ログイン'
		expect(page).to have_content 'ようこそ'
	end


end