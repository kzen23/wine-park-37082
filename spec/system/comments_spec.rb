require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Comments", type: :system do
  before do
    @wine_article = FactoryBot.create(:wine_article)
    @comment = FactoryBot.build(:comment)
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
    @wine_article1 = FactoryBot.create(:wine_article)
    @wine_article2 = FactoryBot.create(:wine_article)
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
    sleep 0.1
  end

  describe 'コメント編集機能' do
    context 'コメント編集ができるとき' do
      it 'ログインしたユーザーは過去に自分が投稿したコメント内容を編集できる' do
      end
    end
    context 'コメント編集ができないとき' do
      it 'ログインしていなければユーザーはコメント編集ができない' do
      end
      it 'ログインしていても自分が投稿したコメント以外は編集ができない' do
      end
    end
  end
end

RSpec.describe "Comments", type: :system do
  before do
    @wine_article1 = FactoryBot.create(:wine_article)
    @wine_article2 = FactoryBot.create(:wine_article)
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
    sleep 0.1
  end

  describe 'コメント削除機能' do
    context 'コメント削除ができるとき' do
      it 'ログインしたユーザーは過去に自分が投稿したコメント内容を削除できる' do
      end
    end
    context 'コメント削除ができないとき' do
      it 'ログインしていなければユーザーはコメント削除できない' do
      end
      it 'ログインしていても自分が投稿したコメント以外は削除できない' do
      end
    end
  end
end


