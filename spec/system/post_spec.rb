require 'rails_helper'

RSpec.describe Post, type: :sytem do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let!(:post) { create(:post, user_id: user.id) }
  let!(:other_post) { create(:other_post, user_id: other_user.id) }

  describe '新規投稿機能' do
    let(:post_title) { '新規投稿' }
    let(:post_comment) { '新規投稿だよ' }
    let(:post_from) { '新規県' }
    let(:post_amount) { '1' }

    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it '新規投稿画面に移行できる' do
        click_link '新規投稿'
        expect(current_path).to eq new_post_path
      end

      context '新規投稿全入力しているとき' do
        before do
          visit new_post_path
          fill_in 'post[title]', with: post_title
          attach_file('post[image]', Rails.root + 'public/post_images/test.jpg')
          fill_in 'post[comment]', with: post_comment
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '成功する' do
          click_button '投稿'
          expect(current_path).to eq posts_path
        end
      end

      context 'タイトル未入力のとき' do
        before do
          visit new_post_path
          fill_in 'post[title]', with: ''
          attach_file('post[image]', Rails.root + 'public/post_images/test.jpg')
          fill_in 'post[comment]', with: post_comment
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '失敗して, メッセージが出る' do
          click_button '投稿'
          expect(page).to have_content('タイトルを入力してください')
        end
      end

      context '画像未入力のとき' do
        before do
          visit new_post_path
          fill_in 'post[title]', with: post_title
          fill_in 'post[comment]', with: post_comment
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '失敗して, メッセージが出る' do
          click_button '投稿'
          expect(page).to have_content('写真を入力してください')
        end
      end

      context 'コメント未入力のとき' do
        before do
          visit new_post_path
          fill_in 'post[title]', with: post_title
          attach_file('post[image]', Rails.root + 'public/post_images/test.jpg')
          fill_in 'post[comment]', with: ''
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '失敗して, メッセージが出る' do
          click_button '投稿'
          expect(page).to have_content('説明orコメントを入力してください')
        end
      end
    end

    context 'ログインしてないとき' do
      it '新規投稿画面に行かず, メッセージが出る' do
        visit new_post_path
        expect(page).to have_content('アカウント登録もしくはログインしてください。')
      end
    end
  end

  describe '投稿一覧表示機能' do
    shared_examples 'userが作成した投稿が表示される' do
      it { expect(page).to have_content 'example' }
    end

    shared_examples 'other_userが作成した投稿が表示される' do
      it { expect(page).to have_content('other_example') }
    end

    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit posts_path
      end

      it_behaves_like 'userが作成した投稿が表示される'
      it_behaves_like 'other_userが作成した投稿が表示される'
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
        visit posts_path
      end

      it_behaves_like 'userが作成した投稿が表示される'
      it_behaves_like 'other_userが作成した投稿が表示される'
    end
  end

  describe '詳細表示機能' do
    shared_examples 'userが作成した投稿の詳細が表示される' do
      it {
        click_link "#{post.title}のリンクid:#{post.id}"
        expect(page).to have_content 'example'
      }
      it { expect(page).to have_content 'exampleです' }
    end

    shared_examples 'other_userが作成した投稿の詳細が表示される' do
      it {
        click_link "#{other_post.title}のリンクid:#{other_post.id}"
        expect(page).to have_content 'other_example'
      }
      it { expect(page).to have_content 'other_exampleです' }
    end

    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit posts_path
      end

      it_behaves_like 'userが作成した投稿の詳細が表示される'
      it_behaves_like 'other_userが作成した投稿の詳細が表示される'
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
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

  describe '編集機能' do
    let(:post_title) { '編集済み' }
    let(:post_comment) { '編集しました' }
    let(:post_from) { '編集県' }
    let(:post_amount) { '11' }

    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit posts_path
      end

      it '編集画面に移行できる' do
        click_link "#{post.title}のリンクid:#{post.id}"
        click_link '編集'
        expect(current_path).to eq edit_post_path(post)
      end

      context '新規投稿全入力しているとき' do
        before do
          click_link "#{post.title}のリンクid:#{post.id}"
          click_link '編集'
          fill_in 'post[title]', with: post_title
          attach_file('post[image]', Rails.root + 'public/post_images/test.jpg')
          fill_in 'post[comment]', with: post_comment
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '成功する' do
          click_button '更新'
          expect(current_path).to eq post_path(post)
        end
      end

      context 'タイトル未入力にしたとき' do
        before do
          click_link "#{post.title}のリンクid:#{post.id}"
          click_link '編集'
          fill_in 'post[title]', with: ''
          attach_file('post[image]', Rails.root + 'public/post_images/test.jpg')
          fill_in 'post[comment]', with: post_comment
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '失敗して, メッセージが出る' do
          click_button '更新'
          expect(page).to have_content('タイトルを入力してください')
        end
      end

      context 'コメント未入力にしたとき' do
        before do
          visit edit_post_path(post)
          fill_in 'post[title]', with: post_title
          attach_file('post[image]', Rails.root + 'public/post_images/test.jpg')
          fill_in 'post[comment]', with: ''
          fill_in 'post[from]', with: post_from
          fill_in 'post[amount]', with: post_amount
        end

        it '失敗して, メッセージが出る' do
          click_button '更新'
          expect(page).to have_content('説明orコメントを入力してください')
        end
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
      end
      it '他人の投稿の編集ボタンは表示されない' do
        visit post_path(post)
        expect(page).to_not have_content('編集')
      end
      it '編集画面に移行できない' do
        visit edit_post_path(post)
        expect(page).to have_content('権限がありません')
      end
    end

    context 'ログインしてないとき' do
      it '編集ボタンは表示されない' do
        visit post_path(post)
        expect(page).to_not have_content('編集')
      end
      it '編集画面に移行できない' do
        visit edit_post_path(post)
        expect(page).to have_content('アカウント登録もしくはログインしてください。')
      end
    end
  end

  describe '削除機能' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit post_path(post)
      end

      it '削除ボタンが表示される' do
        expect(page).to have_content('削除')
      end

      it '削除できる' do
        click_link '削除'
        expect(page).to have_content('削除しました')
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
        visit post_path(post)
      end

      it '他人の投稿の削除ボタンは表示されない' do
        expect(page).to_not have_content('削除')
      end
    end

    context 'ログインしてないとき' do
      it '削除ボタンは表示されない' do
        visit post_path(post)
        expect(page).to_not have_content('削除')
      end
    end
  end

  describe 'いいね機能' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit posts_path
      end

      it 'お気に入り追加ボタンがある' do
        expect(page).to have_content('お気に入り追加')
      end

      it 'お気に入り数が増える', js: true do
        click_link "add-fav-#{post.id}"
        sleep 2
        expect(post.favorites.count).to eq post.fav_count + 1
      end

      it 'お気に入り数が減る', js: true do
        click_link "add-fav-#{post.id}"
        sleep 2
        click_link "del-fav-#{post.id}"
        sleep 2
        expect(post.favorites.count).to eq 0
      end
    end
  end

  describe 'コメント書き込み機能' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it 'userの投稿にコメントできる', js: true do
        visit post_path(post)
        fill_in 'comment[content]', with: 'example'
        click_button '送信'
        expect(page).to have_content 'example'
      end

      it 'other_userの投稿にコメントできる', js: true do
        visit post_path(other_post)
        fill_in 'comment[content]', with: 'ohter_example'
        click_button '送信'
        expect(page).to have_content 'other_example'
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
      end

      it 'userの投稿にコメントできる', js: true do
        visit post_path(post)
        fill_in 'comment[content]', with: 'comment example'
        click_button '送信'
        expect(page).to have_content 'comment example'
      end

      it 'othser_userの投稿にコメントできる', js: true do
        visit post_path(other_post)
        fill_in 'comment[content]', with: 'comment other_example'
        click_button '送信'
        expect(page).to have_content 'comment other_example'
      end
    end

    context 'ログインしていないとき' do
      it 'コメントできない' do
        visit post_path(post)
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe '認証機能' do
    context 'userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it 'other_userの投稿は編集できない' do
        visit "/posts/#{other_post.id}/edit"
        expect(page).to have_content '権限がありません'
      end
    end

    context 'other_userがログインしているとき' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: other_user.email
        fill_in 'パスワード', with: other_user.password
        click_button 'ログイン'
      end

      it 'userの投稿は編集できない' do
        visit "/posts/#{post.id}/edit"
        expect(page).to have_content '権限がありません'
      end
    end
  end
end
