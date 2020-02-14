require 'rails_helper'

RSpec.describe Comment, type: :syetem do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:post) { create(:post, user_id: user.id) }
  let(:other_post) { create(:other_post, user_id: other_user.id) }
  let(:commet) { create(:comment, user_id: user.id, post_id: post.id) }
  let(:other_comment) { create(:other_comment, user_id: other_user.id, post_id: other_post.id) }

  describe 'コメント削除機能' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end
      it 'userのコメント削除できる', js: true do
        visit post_path(post)
        click_link 'コメントを削除する'
        sleep 1
        expect(page).not_to have_content 'comment example'
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
      end
      it 'other_userのコメント削除できる', js: true do
        visit post_path(other_post)
        click_link 'コメントを削除する'
        sleep 1
        expect(page).not_to have_content 'other_comment example'
      end
    end
  end
end
