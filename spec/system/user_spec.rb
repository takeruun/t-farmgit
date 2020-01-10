require 'rails_helper'

RSpec.describe User, type: :system do
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

		it '画像変更できる' do
			visit edit_user_registration_path(user)
			fill_in "メールアドレス", with: user.email
			attach_file("user[image]",Rails.root+'public/post_images/test.jpg')
 			fill_in "現在のパスワード", with: user.password
			click_button '更新'
			expect(current_path).to eq root_path
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

	describe "認証機能" do
		shared_examples 'メッセージが出る' do
			it { expect(page).to have_content("すでにログインしています")}
		end

		context 'ログイン済みのとき, ログインしようとすると失敗する' do
			before do
				visit new_user_session_path
			end
			it_behaves_like 'メッセージが出る'
		end
		
		context 'ログイン済みのとき, 新規登録しようとすると失敗する' do
			before do
				visit new_user_registration_path
			end
			it_behaves_like 'メッセージが出る'
		end
	end

end