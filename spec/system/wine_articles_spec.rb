require 'rails_helper'

def basic_auth(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'WineArticles', type: :system do
  before do
    @user = create(:user)
    @wine_article = build(:wine_article, user: @user)
    sleep 0.1
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
        expect(page).to have_link '投稿する', href: new_wine_article_path
        # 新規投稿ページへ移動する
        click_on '投稿する'
        # 必要な情報を入力する
        input_form(@wine_article)
        # 投稿するボタンを押すとWineArticleモデルのカウントが１上がる
        expect { find('input[name="commit"]').click }.to change { WineArticle.count }.by(1)
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
        expect(page).to have_no_link '投稿する', href: new_wine_article_path
        # URLを直接打ち込んで新規投稿ページへのアクセスを試みる
        visit new_wine_article_path
        # ログイン画面に遷移したことを確認する
        expect(current_path).to eq(new_user_session_path)
        # 新規投稿ページへのリンクがないことを確認する
        expect(page).to have_no_link '投稿する', href: new_wine_article_path
      end
      it 'ログインして必要な情報を入力してももどるのリンクをクリックしたら新規投稿出来ない' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
        # ログインする
        sign_in(@user)
        # 新規投稿ページへのリンクがあることを確認する
        expect(page).to have_link '投稿する', href: new_wine_article_path
        # 新規投稿ページへ移動する
        click_on '投稿する'
        # 必要な情報を入力する
        input_form(@wine_article)
        # もどるのリンクをクリックしてもWineArticleモデルのカウントが上がらないことを確認する
        expect { click_on 'もどる' }.to change { WineArticle.count }.by(0)
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
        expect(page).to have_link '投稿する', href: new_wine_article_path
        # 新規投稿ページへ移動する
        click_on '投稿する'
        # 必要な情報を入力する
        input_form(@wine_article)
        # 投稿するのリンクをクリックしてもモデルのカウントが上がらないことを確認する
        expect { click_on '投稿する' }.to change { WineArticle.count }.by(0)
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
        expect(page).to have_link '投稿する', href: new_wine_article_path
        # 新規投稿ページへ移動する
        click_on '投稿する'
        # 必要な情報を入力する
        input_form(@wine_article)
        # ログアウトのリンクをクリックしてもWineArticleモデルのカウントが上がらないことを確認する
        expect { click_on 'ログアウト' }.to change { WineArticle.count }.by(0)
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
        expect(page).to have_link '投稿する', href: new_wine_article_path
        # 新規投稿ページへ移動する
        click_on '投稿する'
        # 必要な情報を入力する
        input_form(@wine_article)
        # Wine-Park♪のロゴをクリックしてもWineArticleモデルのカウントが上がらないことを確認する
        expect { click_on 'Wine-Park♪' }.to change { WineArticle.count }.by(0)
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
      end
      it 'ログインして必要な情報を入力しても画面上の自身のニックネームをクリックしたら新規投稿出来ない' do
      end
    end
  end
end

RSpec.describe 'WineArticles', type: :system do
  before do
    @wine_article1 = create(:wine_article)
    @wine_article2 = create(:wine_article)
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
        find_link(all('.link1')[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
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
        expect { click_on '更新する' }.to change { WineArticle.count }.by(0)
        # トップページに遷移したことを確認する
        expect(current_path).to eq(root_path)
        # トップページの内容が編集した内容になっていることを確認する
        input_index_confirmation(@wine_article1)
        # 詳細ページに移動する
        visit wine_article_path(@wine_article1.id)
        # 詳細ページの内容が編集した内容になっていることを確認する
        input_edit_confirmation(@wine_article1)
      end
      it 'wine_name_kanaは、あってもなくても過去の自分のワイン記事は編集出来る' do
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
        # 詳細ページ内に編集ページへのリンクがある事を確認する
        expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
        # 編集ページへ移動する
        visit edit_wine_article_path(@wine_article1.id)
        # すでに投稿済みの内容がフォームに入っていることを確認する
        edit_confirmation(@wine_article1)
        # wine_name_kanaの項目を空にする
        input_form_edit(@wine_article1)
        fill_in 'wine_article_wine_name_kana', with: ''
        # 編集してもモデルのアカウントが上がらないことを確認する
        expect { click_on '更新する' }.to change { WineArticle.count }.by(0)
        # トップページに遷移したことを確認する
        expect(current_path).to eq(root_path)
        # トップページの内容が編集した内容になっていることを確認する
        input_index_confirmation(@wine_article1)
        # 詳細ページへ移動する
        visit wine_article_path(@wine_article1.id)
        # 詳細ページの内容が編集した内容になっていることを確認する
        input_edit_confirmation2
      end
      it 'imageは、編集されなかったとしても過去の自分のワイン記事は編集出来る' do
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
        # 詳細ページ内に編集ページへのリンクがある事を確認する
        expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
        # 編集ページへ移動する
        visit edit_wine_article_path(@wine_article1.id)
        # すでに投稿済みの内容がフォームに入っていることを確認する
        edit_confirmation(@wine_article1)
        # 画像を除いた投稿内容を編集する
        input_form2(@wine_article1)
        fill_in 'wine_article_wine_name_kana', with: ''
        # 編集してもモデルのアカウントが上がらないことを確認する
        expect { click_on '更新する' }.to change { WineArticle.count }.by(0)
        # トップページに遷移したことを確認する
        expect(current_path).to eq(root_path)
        # トップページの内容が編集した内容になっていることを確認する
        input_index_confirmation2(@wine_article1)
        # 詳細ページへ移動する
        visit wine_article_path(@wine_article1.id)
        # 詳細ページの内容が編集した内容になっていることを確認する
        input_edit_confirmation3
      end
      it '以前と比べて、何も変更がなく、更新するのボタンを押したとしても過去の自分のワイン記事は編集出来る' do
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
        # 詳細ページ内に編集ページへのリンクがある事を確認する
        expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
        # 編集ページへ移動する
        visit edit_wine_article_path(@wine_article1.id)
        # すでに投稿済みの内容がフォームに入っていることを確認する
        edit_confirmation(@wine_article1)
        # 編集してもモデルのアカウントが上がらないことを確認する
        expect { click_on '更新する' }.to change { WineArticle.count }.by(0)
        # トップページに遷移したことを確認する
        expect(current_path).to eq(root_path)
        # トップページの内容が編集した内容になっていることを確認する
        input_index_confirmation2(@wine_article1)
        # 詳細ページへ移動する
        visit wine_article_path(@wine_article1.id)
        # 詳細ページの内容が編集した内容になっていることを確認する
        input_show_confirmation(@wine_article1.id)
      end
    end
  end
  context '投稿されたワイン記事が編集出来ないとき' do
    it 'ログインしていなれば、ユーザーは、ワイン記事を編集出来ない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # 新規登録とログインのリンクがあることを確認する
      expect(page).to have_link '新規登録', href: new_user_registration_path
      expect(page).to have_link 'ログイン', href: new_user_session_path
      # 編集ページへ移動するための編集するがないことを確認する
      expect(page).to have_no_content('編集する')
      # 直接URLを打ち込んで編集ページへ移動する
      visit edit_wine_article_path(@wine_article1.id)
      # ログイン画面に遷移したことを確認する
      expect(current_path).to eq(new_user_session_path)
    end
    it 'ログインしていてもユーザーは、必要な値を入力しなければ、過去の自分のワイン記事は編集できない' do
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
      # 詳細ページ内に編集ページへのリンクがある事を確認する
      expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
      # 編集ページへ移動する
      visit edit_wine_article_path(@wine_article1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      edit_confirmation(@wine_article1)
      # フォームを全て空にして更新するのボタンを押す
      input_form_edit3
      # 更新に失敗し、編集ページにとどまっている事を確認する
      click_on '更新する'
      expect(current_path).to eq(wine_article_path(@wine_article1.id))
    end
    it 'ログインしていて必要な値を入力してもユーザーは、もどるのリンクをクリックしたら過去の自分のワイン記事を編集できない' do
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
      # 詳細ページ内に編集ページへのリンクがある事を確認する
      expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
      # 編集ページへ移動する
      visit edit_wine_article_path(@wine_article1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      edit_confirmation(@wine_article1)
      # wine_name_kanaのみ空欄にする
      fill_in 'wine_article_wine_name_kana', with: ''
      # もどるのリンクをクリックする
      click_on 'もどる'
      # 詳細ページへ遷移したことを確認する
      expect(current_path).to eq(wine_article_path(@wine_article1.id))
      # 詳細ページの内容が変わっていないことを確認する
      input_show_confirmation(@wine_article1.id)
      # トップページへ移動する
      visit root_path
      # トップページの内容が変わっていないことを確認する
      input_index_confirmation2(@wine_article1)
    end
    it 'ログインしていて必要な値を入力してもユーザーは、ログアウトのリンクをクリックしたら過去の自分のワイン記事を編集出来ない' do
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
      # 詳細ページ内に編集ページへのリンクがある事を確認する
      expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
      # 編集ページへ移動する
      visit edit_wine_article_path(@wine_article1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      edit_confirmation(@wine_article1)
      # wine_name_kanaのみ空欄にする
      fill_in 'wine_article_wine_name_kana', with: ''
      # ログアウトのリンクをクリックする
      click_on 'ログアウト'
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # トップページの内容が変わっていないことを確認する
      input_index_confirmation2(@wine_article1)
      # 詳細ページに移動する
      visit wine_article_path(@wine_article1.id)
      # 詳細ページの内容が変わっていないことを確認する
      input_show_confirmation(@wine_article1.id)
    end
    it 'ログインしていて必要な値を入力してもユーザーは、投稿するのリンクをクリックしたら過去の自分のワイン記事を編集出来ない' do
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
      # 詳細ページ内に編集ページへのリンクがある事を確認する
      expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
      # 編集ページへ移動する
      visit edit_wine_article_path(@wine_article1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      edit_confirmation(@wine_article1)
      # wine_name_kanaのみ空欄にする
      fill_in 'wine_article_wine_name_kana', with: ''
      # 投稿するのリンクをクリックする
      click_on '投稿する'
      # 新規投稿ページに遷移したことを確認する
      expect(current_path).to eq(new_wine_article_path)
      # トップページへ移動する
      visit root_path
      # トップページの内容が変わっていないことを確認する
      input_index_confirmation2(@wine_article1)
      # 詳細ページへ移動する
      visit wine_article_path(@wine_article1.id)
      # 詳細ページの内容が変わっていないことを確認する
      input_show_confirmation(@wine_article1.id)
    end
    it 'ログインしていて必要な値を入力してもユーザーは、Wine-Park♪のロゴをクリックしたら過去の自分のワイン記事を編集出来ない' do
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
      # 詳細ページ内に編集ページへのリンクがある事を確認する
      expect(page).to have_link '編集する', href: edit_wine_article_path(@wine_article1.id)
      # 編集ページへ移動する
      visit edit_wine_article_path(@wine_article1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      edit_confirmation(@wine_article1)
      # wine_name_kanaのみ空欄にする
      fill_in 'wine_article_wine_name_kana', with: ''
      # Wine-park♪のロゴをクリックする
      click_on 'Wine-Park♪'
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページの内容が変わっていないことを確認する
      input_index_confirmation2(@wine_article1)
      # 詳細ページへ移動する
      visit wine_article_path(@wine_article1.id)
      # 詳細ページの内容が変わっていないことを確認する
      input_show_confirmation(@wine_article1.id)
    end
    it 'ログインしていてもユーザーは、自分が過去に投稿したワイン記事でなければ編集出来ない' do
      # Basic認証を通過する
      basic_auth root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # ログインする
      sign_in_edit(@wine_article1.user)
      # 投稿したワイン記事２をクリックする
      find_link(all('.link1')[@wine_article2.id], href: wine_article_path(@wine_article2.id)).click
      # 詳細ページに移動した事を確認する
      expect(current_path).to eq wine_article_path(@wine_article2.id)
      # 編集するのリンクがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_wine_article_path(@wine_article2.id)
      # 直接URLを打ち込んで編集ページへ移動する
      visit edit_wine_article_path(@wine_article2.id)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
    end
    it 'ログインしていて必要な値を入力してもユーザーは、自身のニックネームのリンクをクリックしたら過去の自分のワイン記事を編集出来ない' do
    end
  end
end

RSpec.describe 'WineArticles', type: :system do
  before do
    @wine_article1 = create(:wine_article)
    @wine_article2 = create(:wine_article)
    sleep 0.1
  end
  describe 'ワイン投稿記事削除機能' do
    context 'ワイン投稿記事が削除できるとき' do
      it 'ログインしたユーザーは自分が過去に投稿したワイン記事を削除できる' do
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
        # 詳細ページに削除へのリンクがあることを確認する
        expect(page).to have_link '削除する', href: wine_article_path(@wine_article1)
        # 投稿を削除するとレコードの数が1減ることを確認する
        expect { click_on '削除する' }.to change { WineArticle.count }.by(-1)
        # トップページに遷移したことを確認する
        expect(current_path).to eq(root_path)
        # ワイン記事１の詳細ページへのリンクが存在しないことを確認する
        expect(page).to have_no_link '(".link1")[@wine_article1.id]', href: wine_article_path(@wine_article1.id)
      end
    end
    context 'ワイン投稿記事が削除できないとき' do
      it 'ログインしたユーザーは他ユーザーが過去に投稿したワイン記事を削除できない' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
        # ログインする
        sign_in_edit(@wine_article1.user)
        # 投稿したワイン記事２をクリックする
        find_link(all('.link1')[@wine_article2.id], href: wine_article_path(@wine_article2.id)).click
        # 詳細ページに移動した事を確認する
        expect(current_path).to eq wine_article_path(@wine_article2.id)
        # 詳細ページに削除するのリンクがないことを確認する
        expect(page).to have_no_link '削除する', href: wine_article_path(@wine_article2.id)
      end
      it 'ログインしていないとユーザーは過去に投稿したワイン記事を削除できない' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
        # ログインしていないので、ワイン記事が存在しないことを確認する
        exist_confirmation(@wine_article1)
        exist_confirmation2(@wine_article2)
      end
    end
  end
end

RSpec.describe 'WineArticles', type: :system do
  before do
    @wine_article1 = create(:wine_article)
    @wine_article2 = create(:wine_article)
    sleep 0.1
  end
  describe 'ワイン投稿記事詳細機能' do
    context 'ワイン投稿記事の詳細が見れるとき' do
      it 'ログインしたユーザーは投稿されたすべてのワイン記事の詳細を見ることができる' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
        # ログインする
        sign_in_edit(@wine_article1.user)
        # 投稿したワイン記事１をクリックする
        find_link(all('.link1')[@wine_article1.id], href: wine_article_path(@wine_article1.id)).click
        # ワイン記事１の詳細ページに移動した事を確認する
        expect(current_path).to eq wine_article_path(@wine_article1.id)
        # ワイン記事１の詳細内容が存在することを確認する
        input_show_confirmation(@wine_article1.id)
        # トップページに戻る
        visit root_path
        # 投稿されたワイン記事２をクリックする
        find_link(all('.link1')[@wine_article2.id], href: wine_article_path(@wine_article2.id)).click
        # ワイン記事２の詳細ページに移動した事を確認する
        expect(current_path).to eq wine_article_path(@wine_article2.id)
        # ワイン記事２の詳細内容が存在することを確認する
        input_show_confirmation2(@wine_article2)
      end
    end
    context 'ワイン投稿記事の詳細が見れないとき' do
      it 'ログインができないと投稿されたワイン記事を見ることはできない' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
        # ワイン記事１が存在しない事を確認する
        exist_confirmation(@wine_article1)
        # ワイン記事２が存在しない事を確認する
        exist_confirmation2(@wine_article2)
      end
    end
  end
end
