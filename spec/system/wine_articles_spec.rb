require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "WineArticles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @wine_article = FactoryBot.build(:wine_article)
    @wine_article.user_id = @user.id
  end

  describe 'ワイン記事新規投稿' do
    context 'ワイン記事新規投稿できるとき' do
      it 'ログインしたユーザーは新規投稿できる' do
        # Basic認証を通過する
          basic_auth root_path
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # ログインする
          sign_in(@user)
        # 新規投稿ページへのリンクがあることを確認する
          expect(page).to have_link "投稿する", href: new_wine_article_path
        # 新規投稿ページへ移動する
          click_on '投稿する'
        # 必要な情報を入力する
          input_form(@wine_article)
        # 投稿するボタンを押すとWineArticleモデルのカウントが１上がる
          expect{find('input[name="commit"]').click}.to change { WineArticle.count }.by(1)
        # 投稿が終わるとトップページに遷移することを確認する
          expect(current_path).to eq(root_path)
        # トップページには先ほど投稿したワイン記事の画像があることを確認する
          expect(page).to have_selector('img')
        # トップページには先ほど投稿したワイン記事のタイトルがあることを確認する
          expect(page).to have_content(@wine_article.title)
        # トップページには先ほど投稿したワイン記事の値段があることを確認する
          expect(page).to have_content(@wine_article.wine_price)
        # トップページには先ほど投稿したワイン記事の投稿者名があることを確認する
          expect(page).to have_content(@wine_article.user.nickname)
      end
    end
    context 'ワイン記事新規投稿出来ないとき' do
      it 'ログインしていないと新規投稿出来ない' do
        # Basic認証を通過する
          basic_auth root_path
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # 新規投稿ページへのリンクがないことを確認する
          expect(page).to have_no_link "投稿する", href: new_wine_article_path
        # URLを直接打ち込んで新規投稿ページへのアクセスを試みる
          visit new_wine_article_path
        # ログイン画面に遷移したことを確認する
          expect(current_path).to eq(new_user_session_path)
        # 新規投稿ページへのリンクがないことを確認する
          expect(page).to have_no_link "投稿する", href: new_wine_article_path
      end
      it 'ログインして必要な情報を入力してももどるのリンクをクリックしたら新規投稿出来ない' do
        # Basic認証を通過する
          basic_auth root_path
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # ログインする
          sign_in(@user)
        # 新規投稿ページへのリンクがあることを確認する
          expect(page).to have_link "投稿する", href: new_wine_article_path
        # 新規投稿ページへ移動する
          click_on '投稿する'
        # 必要な情報を入力する
          input_form(@wine_article)
        # もどるのリンクをクリックしてもWineArticleモデルのカウントが上がらないことを確認する
          expect{click_on 'もどる'}.to change { WineArticle.count }.by(0)
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
      end
      it 'ログインして必要な情報を入力しても投稿するのリンクをクリックしたら新規投稿出来ない' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # ログインする
          sign_in(@user)
        # 新規投稿ページへのリンクがあることを確認する
          expect(page).to have_link "投稿する", href: new_wine_article_path
        # 新規投稿ページへ移動する
          click_on '投稿する'
        # 必要な情報を入力する
          input_form(@wine_article)
        # 投稿するのリンクをクリックしてもモデルのカウントが上がらないことを確認する
          expect{click_on '投稿する'}.to change { WineArticle.count }.by(0)
        # 新規投稿ページに移動したことを確認する
          expect(current_path).to eq(new_wine_article_path)
      end
      it 'ログインして必要な情報を入力してもログアウトのリンクをクリックしたら新規投稿出来ない' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # ログインする
          sign_in(@user)
        # 新規投稿ページへのリンクがあることを確認する
          expect(page).to have_link "投稿する", href: new_wine_article_path
        # 新規投稿ページへ移動する
          click_on '投稿する'
        # 必要な情報を入力する
          input_form(@wine_article)
        # ログアウトのリンクをクリックしてもWineArticleモデルのカウントが上がらないことを確認する
          expect{click_on 'ログアウト'}.to change { WineArticle.count }.by(0)
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # ログイン状態でなく、また新規投稿が出来ないことを確認する
          expect(page).to have_link '新規登録', href: new_user_registration_path
          expect(page).to have_link 'ログイン', href: new_user_session_path
          expect(page).to have_no_link '投稿する', href: new_wine_article_path
      end
      it 'ログインして必要な情報を入力してもWine-Park♪のロゴをクリックしたら新規投稿出来ない' do
        # Basic認証を通過する
          basic_auth root_path
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
        # ログインする
          sign_in(@user)
        # 新規投稿ページへのリンクがあることを確認する
          expect(page).to have_link "投稿する", href: new_wine_article_path
        # 新規投稿ページへ移動する
          click_on '投稿する'
        # 必要な情報を入力する
          input_form(@wine_article)
        # Wine-Park♪のロゴをクリックしてもWineArticleモデルのカウントが上がらないことを確認する
          expect{ click_on 'Wine-Park♪' }.to change { WineArticle.count }.by(0)
        # トップページに移動したことを確認する
          expect(current_path).to eq(root_path)
      end
    end
  end
end
