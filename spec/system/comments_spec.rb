require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Comments", type: :system do
  before do
    @wine_article = create(:wine_article)
    @comment = build(:comment, user: @wine_article.user, wine_article: @wine_article)
    sleep 0.1
  end

  describe 'コメント新規投稿' do
    context 'コメント新規投稿できるとき' do
      it 'ログインしたユーザーはワイン記事の詳細ページでコメントができる' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in2(@wine_article.user)
      # 投稿したワイン記事１をクリックする
      find_link(all('.link1')[@wine_article.id], href: wine_article_path(@wine_article.id)).click
      # 詳細ページに移動した事を確認する
      expect(current_path).to eq wine_article_path(@wine_article.id)
      # コメントの新規投稿のためのリンクが存在する事を確認する
      expect(page).to have_link 'コメントする', href: new_wine_article_comment_path(@wine_article.id)
      # コメントの新規投稿ページへ移動する
      visit new_wine_article_comment_path(@wine_article.id)
      # コメントを投稿する
      fill_in 'comment_text', with: @comment
      # コメントするをクリックすると、Commentモデルのカウントが１上がることを確認する
      expect { click_on 'コメントする' }.to change { Comment.count }.by(1)
      # ワイン記事詳細ページへ遷移したことを確認する
      expect(current_path).to eq(wine_article_path(@wine_article.id))
      # 先ほど投稿したコメント内容が反映されている事を確認する
      expect(page).to have_content @comment
      end
    end
    context 'コメント新規投稿できないとき' do
      it 'ログインしていなければユーザーはコメントの新規投稿ができない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # 詳細ページへのリンクがないことを確認する
      expect(page).to have_no_link (all('.link1')[@wine_article.id]), href: wine_article_path(@wine_article.id) 
      # 詳細ページへ直接移動を試みる
      visit wine_article_path(@wine_article.id)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq(new_user_session_path)
      # コメント新規投稿ページへの直接移動を試みる
      visit new_wine_article_comment_path(@wine_article.id)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq(new_user_session_path)
      end
      it 'ログインしていてもtextの値が空ではコメントの新規投稿はできない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in2(@wine_article.user)
      # 投稿したワイン記事１をクリックする
      find_link(all('.link1')[@wine_article.id], href: wine_article_path(@wine_article.id)).click
      # 詳細ページに移動した事を確認する
      expect(current_path).to eq wine_article_path(@wine_article.id)
      # コメントの新規投稿のためのリンクが存在する事を確認する
      expect(page).to have_link 'コメントする', href: new_wine_article_comment_path(@wine_article.id)
      # コメントの新規投稿ページへ移動する
      visit new_wine_article_comment_path(@wine_article.id)
      # コメントを投稿する
      fill_in 'comment_text', with: ""
      # コメントするをクリックしてもモデルのカウントが上がらない事を確認する
      expect { click_on 'コメントする' }.to change { Comment.count }.by(0)
      # 保存に失敗し、コメント新規投稿の画面にいることを確認する
      expect(current_path).to eq(wine_article_comments_path(@wine_article.id))
      end
    end
  end
end

RSpec.describe "Comments", type: :system do
  before do
    @wine_article1 = create(:wine_article)
    @comment1 = create(:comment, user: @wine_article1.user, wine_article: @wine_article1)
    @wine_article2 = create(:wine_article)
    @comment2 =create(:comment, user: @wine_article2.user, wine_article: @wine_article2)
    sleep 0.1
  end

  describe 'コメント編集機能' do
    context 'コメント編集ができるとき' do
      it 'ログインしたユーザーは過去に自分が投稿したコメント内容を編集できる' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # 投稿したワイン記事１をクリックする
      find_link(all('.link1')[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
      # 詳細ページに移動した事を確認する
      expect(current_path).to eq wine_article_path(@wine_article1.id)
      # コメント一覧に編集のリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_wine_article_comment_path(@wine_article1, @comment1)
      # 編集をクリックする
      click_on '編集'
      # 編集ページに遷移したことを確認する
      expect(current_path).to eq(edit_wine_article_comment_path(@wine_article1, @comment1))
      # 過去の投稿が表示されている事を確認する
      expect(page).to have_content(@comment1.text)
      # コメント内容を書き換える
      fill_in 'comment_text', with: '美味しそうですね！'
      # 更新するをクリックする
      click_on '更新する'
      # データベースの内容が更新されたことを確認する
      expect(@comment1.reload.text).to eq(@comment1.text)
    end
    end
    context 'コメント編集ができないとき' do
      it 'ログインしていなければユーザーはコメント編集ができない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # 詳細ページへのリンクがないことを確認する
      expect(page).to have_no_link (all('.link1')[@wine_article1.id]), href: wine_article_path(@wine_article1.id) 
      expect(page).to have_no_link (all('.link1')[@wine_article2.id]), href: wine_article_path(@wine_article2.id) 
      # 詳細ページへ直接移動を試みる
      visit wine_article_path(@wine_article1.id)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq(new_user_session_path)
      # 編集ページへの直接移動を試みる1
      visit edit_wine_article_comment_path(@wine_article1, @comment1)
      # ログイン画面に移動したことを確認する
      expect(current_path).to eq(new_user_session_path)
      # 編集ページへの直接移動を試みる2
      visit edit_wine_article_comment_path(@wine_article2, @comment2)
      # ログイン画面に移動したことを確認する
      expect(current_path).to eq(new_user_session_path)
      end
      it 'ログインしていても自分が投稿したコメント以外は編集ができない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # 投稿したワイン記事２をクリックする
      find_link(all('.link1')[@wine_article2.id], href: wine_article_path(@wine_article2.id)).click
      # ワイン記事２の詳細ページに移動したことを確認する
      expect(current_path).to eq(wine_article_path(@wine_article2.id))
      # 編集ページへのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_wine_article_comment_path(@wine_article2, @comment2)
      end
      it 'ログインしていて自分が投稿したコメントでも値が空では編集できない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # 投稿したワイン記事１をクリックする
      find_link(all('.link1')[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
      # 詳細ページに移動した事を確認する
      expect(current_path).to eq wine_article_path(@wine_article1.id)
      # コメント一覧に編集のリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_wine_article_comment_path(@wine_article1, @comment1)
      # 編集をクリックする
      click_on '編集'
      # 編集ページに遷移したことを確認する
      expect(current_path).to eq(edit_wine_article_comment_path(@wine_article1, @comment1))
      # 過去の投稿が表示されている事を確認する
      expect(page).to have_content(@comment1.text)
      # コメント内容を空にする
      fill_in 'comment_text', with: ""
      # 更新するをクリックする
      click_on '更新する'
      # 保存に失敗したので、編集ページにとどまったままなことを確認する
      expect(current_path).to eq(wine_article_comment_path(@wine_article1, @comment1))
      end
    end
  end
end

RSpec.describe "Comments", type: :system do
  before do
    @wine_article1 = create(:wine_article)
    @wine_article2 = create(:wine_article)
    @comment1 = create(:comment, user: @wine_article1.user, wine_article: @wine_article1)
    @comment2 = create(:comment, user: @wine_article2.user, wine_article: @wine_article2)
    sleep 0.1
  end

  describe 'コメント削除機能' do
    context 'コメント削除ができるとき' do
      it 'ログインしたユーザーは過去に自分が投稿したコメント内容を削除できる' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # 投稿したワイン記事１をクリックする
      find_link(all('.link1')[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
      # 詳細ページに移動した事を確認する
      expect(current_path).to eq wine_article_path(@wine_article1.id)
      # 削除のリンクがあることを確認する
      expect(page).to have_link '削除', href: wine_article_comment_path(@wine_article1, @comment1)
      # 削除をクリックするとモデルのカウントが１下がる事を確認する
      expect{ click_on '削除' }.to change { Comment.count }.by(-1)
      # ワイン記事１の詳細ページに移動したことを確認する
      expect(current_path).to eq(wine_article_path(@wine_article1.id))
      # ワイン記事１の詳細ページに過去に投稿した自分のコメントがない事を確認する
      expect(page).to have_no_content(@comment1.text)
      end
    end
    context 'コメント削除ができないとき' do
      it 'ログインしていなければユーザーはコメント削除できない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # 詳細ページへのリンクがないことを確認する
      expect(page).to have_no_link (all('.link1')[@wine_article1.id]), href: wine_article_path(@wine_article1.id) 
      expect(page).to have_no_link (all('.link1')[@wine_article2.id]), href: wine_article_path(@wine_article2.id) 
      # 詳細ページへ直接移動を試みる1
      visit wine_article_path(@wine_article1.id)
      # ログイン画面に移動したことを確認する
      expect(current_path).to eq(new_user_session_path)
      # 詳細ページへ直接移動を試みる2
      visit wine_article_path(@wine_article2.id)
      # ログイン画面に移動したことを確認する
      expect(current_path).to eq(new_user_session_path)
      end
      it 'ログインしていても自分が投稿したコメント以外は削除できない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # 投稿したワイン記事２をクリックする
      find_link(all('.link1')[@wine_article2.id], href: wine_article_path(@wine_article2.id)).click
      # ワイン記事２の詳細ページに移動したことを確認する
      expect(current_path).to eq(wine_article_path(@wine_article2.id))
      # 削除へのリンクがないことを確認する
      expect(page).to have_no_link '削除', href: wine_article_comment_path(@wine_article2, @comment2)
      end
    end
  end
end


