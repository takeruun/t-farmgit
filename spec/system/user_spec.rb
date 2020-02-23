require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let!(:post) { create(:post, user_id: user.id) } 
  let!(:other_post) { create(:other_post, user_id: other_user.id) }
  let!(:favorite) { create(:favorite, post_id: other_post.id, user_id: user.id) }
  let!(:other_favorite) { create(:favorite, post_id: post.id, user_id: other_user.id) }

  describe '投稿表示' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it '自分(user)の投稿したものが見れる' do
        visit user_path(user)
        expect(page).to have_content 'exampleです'
      end

      it '自分(user)がお気に入りしている投稿が見れる' do
        visit user_favorites_path(user)
        expect(page).to have_content 'other_exampleです'
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
      end

      it '自分(other_user)の投稿したものが見れる' do
        visit user_path(other_user)
        expect(page).to have_content 'other_exampleです'
      end

      it '自分(other_user)がお気に入りしている投稿が見れる' do
        visit user_favorites_path(other_user)
        expect(page).to have_content 'exampleです'
      end
    end
  end

  describe '編集機能' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end
      it 'メールアドレス変更できる' do
        visit edit_user_registration_path(user)
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in '現在のパスワード', with: user.password
        click_button '更新'
        expect(user.reload.email).to eq 'test@example.com'
      end

      it '画像変更できる' do
        visit edit_user_registration_path(user)
        fill_in 'メールアドレス', with: user.email
        attach_file('user[image]', Rails.root + 'public/post_images/test.jpg')
        fill_in '現在のパスワード', with: user.password
        click_button '更新'
        expect(current_path).to eq root_path
      end

      it 'パスワード変更できる' do
        visit edit_user_registration_path(user)
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'example'
        fill_in '確認用パスワード', with: 'example'
        fill_in '現在のパスワード', with: user.password
        click_button '更新'
        user.reload
        expect(user.valid_password?('example')).to eq(true)
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
      end
      it 'メールアドレス変更できる' do
        visit edit_user_registration_path(other_user)
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in '現在のパスワード', with: other_user.password
        click_button '更新'
        expect(other_user.reload.email).to eq 'test@example.com'
      end

      it '画像変更できる' do
        visit edit_user_registration_path(other_user)
        fill_in 'メールアドレス', with: other_user.email
        attach_file('user[image]', Rails.root + 'public/post_images/test.jpg')
        fill_in '現在のパスワード', with: other_user.password
        click_button '更新'
        expect(current_path).to eq root_path
      end

      it 'パスワード変更できる' do
        visit edit_user_registration_path(other_user)
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: 'other_example'
        fill_in '確認用パスワード', with: 'other_example'
        fill_in '現在のパスワード', with: other_user.password
        click_button '更新'
        other_user.reload
        expect(other_user.valid_password?('other_example')).to eq(true)
      end
    end
  end

  describe '認証機能' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end
    shared_examples 'メッセージが出る' do
      it { expect(page).to have_content('すでにログインしています') }
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
