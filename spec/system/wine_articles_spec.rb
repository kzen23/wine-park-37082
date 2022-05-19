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
      it 'ログインして必要な情報を入力しても画面上の自身のニックネームをクリックしたら新規投稿出来ない' do
      end
    end
  end
end

  RSpec.describe "WineArticles", type: :system do
    before do
      @wine_article1 = FactoryBot.create(:wine_article)
      @wine_article2 = FactoryBot.create(:wine_article)
      sleep 0.1
    end

    describe 'ワイン投稿記事編集' do
      context '投稿されたワイン記事が編集出来るとき' do
        it 'ログインしたユーザーは、過去の自分のワイン記事を編集出来る' do
          # Basic認証を通過する
            basic_auth root_path
          # トップページに移動したことを確認する
            expect(current_path).to eq(root_path)
          # ログインする
            sign_in_edit(@wine_article1.user)
          # 投稿したワイン記事１をクリックする
            find_link(all(".link1")[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
          # 詳細ページに移動した事を確認する
            expect(current_path).to eq wine_article_path(@wine_article1.id)
          # 詳細ページ内に編集ページへのリンクがある事を確認する
            expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
          # 編集ページへ移動する
            visit edit_wine_article_path(@wine_article1.id)
          # すでに投稿済みの内容がフォームに入っていることを確認する
            edit_confirmation(@wine_article1)
          # 投稿内容を編集する
            input_form_edit(@wine_article1)
          # 編集してもモデルのアカウントが上がらないことを確認する
            expect{click_on '更新する'}.to change { WineArticle.count }.by(0)
          # 詳細ページに遷移したことを確認する
            expect(current_path).to eq(wine_article_path(@wine_article1.id))
          # 詳細ページの内容が編集した内容になっていることを確認する
            input_edit_confirmation
          # トップページの内容が編集した内容になっていることを確認する
            input_index_confirmation(@wine_article1)
        end
        it 'wine_name_kanaは、あってもなくても過去の自分のワイン記事は編集出来る' do
          # Basic認証を通過する
          basic_auth root_path
          # トップページに移動したことを確認する
            expect(current_path).to eq(root_path)
          # ログインする
            sign_in_edit(@wine_article1.user)
          # 投稿したワイン記事１をクリックする
            find_link(all(".link1")[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
          # 詳細ページに移動した事を確認する
            expect(current_path).to eq wine_article_path(@wine_article1.id)
          # 詳細ページ内に編集ページへのリンクがある事を確認する
            expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
          # 編集ページへ移動する
            visit edit_wine_article_path(@wine_article1.id)
          # すでに投稿済みの内容がフォームに入っていることを確認する
            edit_confirmation(@wine_article1)
          # wine_name_kanaの項目を空にする
            input_form_edit(@wine_article1)
            fill_in 'wine_article_wine_name_kana', with: ""
          # 編集してもモデルのアカウントが上がらないことを確認する
          expect{click_on '更新する'}.to change { WineArticle.count }.by(0)
          # 詳細ページに遷移したことを確認する
          expect(current_path).to eq(wine_article_path(@wine_article1.id))
          # 詳細ページの内容が編集した内容になっていることを確認する
          input_edit_confirmation2
          # トップページの内容が編集した内容になっていることを確認する
          input_index_confirmation(@wine_article1)
        end 
        it 'imageは、編集されなかったとしても過去の自分のワイン記事は編集出来る' do
          # Basic認証を通過する
          basic_auth root_path
          # トップページに移動したことを確認する
            expect(current_path).to eq(root_path)
          # ログインする
            sign_in_edit(@wine_article1.user)
          # 投稿したワイン記事１をクリックする
            find_link(all(".link1")[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
          # 詳細ページに移動した事を確認する
            expect(current_path).to eq wine_article_path(@wine_article1.id)
          # 詳細ページ内に編集ページへのリンクがある事を確認する
            expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
          # 編集ページへ移動する
            visit edit_wine_article_path(@wine_article1.id)
          # すでに投稿済みの内容がフォームに入っていることを確認する
            edit_confirmation(@wine_article1)
          # 画像を除いた投稿内容を編集する
            input_form_edit2
          # 編集してもモデルのアカウントが上がらないことを確認する
            expect{click_on '更新する'}.to change { WineArticle.count }.by(0)
          # 詳細ページに遷移したことを確認する
            expect(current_path).to eq(wine_article_path(@wine_article1.id))
          # 詳細ページの内容が編集した内容になっていることを確認する
            input_edit_confirmation3
          # トップページの内容が編集した内容になっていることを確認する
          input_index_confirmation2(@wine_article1)
        end
        it '以前と比べて、何も変更がなく、更新するのボタンを押したとしても過去の自分のワイン記事は編集出来る' do
          # Basic認証を通過する
          basic_auth root_path
          # トップページに移動したことを確認する
            expect(current_path).to eq(root_path)
          # ログインする
            sign_in_edit(@wine_article1.user)
          # 投稿したワイン記事１をクリックする
            find_link(all(".link1")[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
          # 詳細ページに移動した事を確認する
            expect(current_path).to eq wine_article_path(@wine_article1.id)
          # 詳細ページ内に編集ページへのリンクがある事を確認する
            expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
          # 編集ページへ移動する
            visit edit_wine_article_path(@wine_article1.id)
          # すでに投稿済みの内容がフォームに入っていることを確認する
            edit_confirmation(@wine_article1)
          # 編集してもモデルのアカウントが上がらないことを確認する
          expect{click_on '更新する'}.to change { WineArticle.count }.by(0)
          # 詳細ページに遷移したことを確認する
            expect(current_path).to eq(wine_article_path(@wine_article1.id))
          # 詳細ページの内容が編集した内容になっていることを確認する
            input_edit_confirmation4(@wine_article1)
        end
      end
    end
    context '投稿されたワイン記事が編集出来ないとき' do
      it 'ログインしていなれば、ユーザーは、ワイン記事を編集出来ない' do
      end
      it 'ログインしていてもユーザーは、必要な値を入力しなければ、過去の自分のワイン記事は編集できない' do
      end
      it 'ログインしていて必要な値を入力してもユーザーは、もどるのリンクをクリックしたら過去の自分のワイン記事を編集できない' do
      end
      it 'ログインしていて必要な値を入力してもユーザーは、ログアウトのリンクをクリックしたら過去の自分のワイン記事を編集出来ない' do
      end
      it 'ログインしていて必要な値を入力してもユーザーは、投稿するのリンクをクリックしたら過去の自分のワイン記事を編集出来ない' do
      end
      it 'ログインしていて必要な値を入力してもユーザーは、Wine-Park♪のロゴをクリックしたら過去の自分のワイン記事を編集出来ない' do
      end
      it 'ログインしていて必要な値を入力してもユーザーは、自身のニックネームのリンクをクリックしたら過去の自分のワイン記事を編集出来ない' do
      end
      it 'ログインしていてもユーザーは、自分が過去に投稿したワイン記事でなければ編集出来ない' do
      end
      it 'ログインしているユーザーが他のユーザーの編集ページへのURLを直接、入力したとしても自分が過去に投稿したワイン記事以外は編集出来ない' do
      end
    end
  end



