require 'rails_helper'

RSpec.describe Uesr, type: :systen do
	let(:user){create(:user)}

	before do
		visit new_user_session_path
		fill_in "メールアドレス", with: user.email
		fill_in "パスワード", with: user.password
		click_button 'ログイン'
	end

	describe "編集機能" do
		it 'メールアドレス変更できる' do
			visit edit_user_registration_path(user)
			fill_in "メールアドレス", with: 'test@example.com'
			fill_in "現在のパスワード", with: user.password
			click_button '更新'
			expect(user.reload.email).to eq 'test@example.com'
		end

		it 'パスワード変更できる' do
			visit edit_user_registration_path(user)
			fill_in "メールアドレス", with: user.email
			fill_in "パスワード", with: 'example'
			fill_in "確認用パスワード", with: 'example'
 			fill_in "現在のパスワード", with: user.password
			click_button '更新'
			user.reload
			expect(user.valid_password?("example")).to eq(true)
		end
	end

end