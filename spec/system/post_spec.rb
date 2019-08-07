require 'rails_helper'

RSpec.describe Post, type: :sytem do
	let(:user){create(:user)}
	let(:other_user){create(:other_user)}
	let!(:post){create(:post, user_id: user.id)}
	let!(:other_post){create(:other_post, user_id: other_user.id)}

	describe "新規投稿機能" do
		let(:post_title){'新規投稿'}
		let(:post_comment){'新規投稿だよ'}
		let(:post_from){'新規県'}
		let(:post_amount){'33'}

		context 'userがログインしているとき' do
			before do
				visit new_user_session_path
				fill_in "メールアドレス", with: user.email
				fill_in "パスワード", with: user.password
				click_button 'ログイン'
			end

			it '新規投稿画面に移行できる' do
				click_link '新規投稿'
			end

			context '新規投稿全入力しているとき' do
				before do
					visit new_post_path
					fill_in "post[title]", with: post_title
					attach_file("post[image]",Rails.root+'public/post_images/1.jpg')
					fill_in "post[comment]", with: post_comment
					fill_in "post[from]", with: post_from
					fill_in "post[amount]", with: post_amount
				end

				it '成功する' do
					click_button "投稿"
					expect(current_path).to eq posts_path
				end

			end

			context 'タイトル未入力のとき' do
				before do
					visit new_post_path
					fill_in "post[title]", with: ''
					attach_file("post[image]",Rails.root+'public/post_images/1.jpg')
					fill_in "post[comment]", with: post_comment
					fill_in "post[from]", with: post_from
					fill_in "post[amount]", with: post_amount
				end

				it '失敗して, メッセージが出る' do
					click_button "投稿"
					expect(page).to have_content("タイトルを入力してください")
				end
			end

			context '画像未入力のとき' do
				before do
					visit new_post_path
					fill_in "post[title]", with: post_title
					fill_in "post[comment]", with: post_comment
					fill_in "post[from]", with: post_from
					fill_in "post[amount]", with: post_amount
				end

				it '失敗して, メッセージが出る' do
					click_button "投稿"
					expect(page).to have_content("写真を入力してください")
				end
			end

			context 'コメント未入力のとき' do
				before do
					visit new_post_path
					fill_in "post[title]", with: post_title
					attach_file("post[image]",Rails.root+'public/post_images/1.jpg')
					fill_in "post[comment]", with: ''
					fill_in "post[from]", with: post_from
					fill_in "post[amount]", with: post_amount
				end

				it '失敗して, メッセージが出る' do
					click_button "投稿"
					expect(page).to have_content("説明orコメントを入力してください")
				end
			end

		end


	end

	describe "投稿一覧表示機能" do
		shared_examples 'userが作成した投稿が表示される' do
			it { expect(page).to have_content ("example")}
		end

		shared_examples 'other_userが作成した投稿が表示される' do
			it { expect(page).to have_content("other_example")}
		end

		context 'userがログインしているとき' do
			before do
				visit new_user_session_path
				fill_in "メールアドレス", with: user.email
				fill_in "パスワード", with: user.password
				click_button 'ログイン'
				visit posts_path
			end

			it_behaves_like 'userが作成した投稿が表示される'
			it_behaves_like 'other_userが作成した投稿が表示される'
		end

		context 'other_userがログインしているとき' do
			before do
				visit new_user_session_path
				fill_in "メールアドレス", with: other_user.email
				fill_in "パスワード", with: other_user.password
				click_button 'ログイン'
				visit posts_path
			end

			it_behaves_like 'userが作成した投稿が表示される'
			it_behaves_like 'other_userが作成した投稿が表示される'
		end

	end

	describe "詳細表示機能" do
		shared_examples 'userが作成した投稿の詳細が表示される' do
			it { click_link "#{post.title}の写真id:#{post.id}"
				 expect(page).to have_content ("example")}
			it { expect(page).to have_content ("exampleです")}
		end

		shared_examples 'other_userが作成した投稿の詳細が表示される' do
			it { click_link "#{other_post.title}の写真id:#{other_post.id}"
				 expect(page).to have_content("other_example")}
			it { expect(page).to have_content("other_exampleです")}
		end

		context 'userがログインしているとき' do
			before do
				visit new_user_session_path
				fill_in "メールアドレス", with: user.email
				fill_in "パスワード", with: user.password
				click_button 'ログイン'
				visit posts_path
			end

			it_behaves_like 'userが作成した投稿の詳細が表示される'
			it_behaves_like 'other_userが作成した投稿の詳細が表示される'
		end

		context 'other_userがログインしているとき' do
			before do
				visit new_user_session_path
				fill_in "メールアドレス", with: other_user.email
				fill_in "パスワード", with: other_user.password
				click_button 'ログイン'
				visit posts_path
			end

			it_behaves_like 'other_userが作成した投稿の詳細が表示される'
			it_behaves_like 'userが作成した投稿の詳細が表示される'
		end

		context 'ログインしてないとき' do
			before do
				visit posts_path
			end

			it_behaves_like 'userが作成した投稿の詳細が表示される'
			it_behaves_like 'other_userが作成した投稿の詳細が表示される'
		end
	end

	
end