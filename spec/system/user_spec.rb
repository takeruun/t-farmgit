require 'rails_helper'

RSpec.describe User, type: :system do
	let(:user){create(:user)}
	
	describe "編集機能" do
		before do
			visit new_user_session_path
			fill_in "メールアドレス", with: user.email
			fill_in "パスワード", with: user.password
			click_button 'ログイン'
		end

		it 'メールアドレス変更できる' do
			visit edit_user_registration_path(user)
			fill_in "メールアドレス", with: 'test@example.com'
			fill_in "現在のパスワード", with: user.password
			click_button '更新'
			expect(user.reload.email).to eq 'test@example.com'
		end

		it '画像変更できる' do
			visit edit_user_registration_path(user)
			fill_in "メールアドレス", with: user.email
			pending "image fieldがないというエラーが出る"
			attach_file image, with: File.join(Rails.root, 'public/user_images/a.jpg')
 			fill_in "現在のパスワード", with: user.password
			click_button '更新'
			expect(user.reload.image).to eq "example.jpg"
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