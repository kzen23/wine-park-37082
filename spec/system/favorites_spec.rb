require 'rails_helper'

RSpec.describe 'Favorites', type: :system do
  def basic_auth(path)
    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  before do
    @wine_article1 = create(:wine_article)
    @wine_article2 = create(:wine_article)
  end

  describe 'いいね機能' do
    context 'いいねするといいねを解除する' do
      it '一人のユーザーがワイン投稿記事にいいねすると関係が成り立ち、解除すると関係がなくなる' do
        # Basic認証を通過する
        basic_auth root_path
        # トップページに移動したことを確認する
        expect(current_path).to eq(root_path)
        # ログインする
        sign_in_edit(@wine_article1.user)
        # 投稿したワイン記事2をクリックする
        find_link(all('.link1')[@wine_article2.id], href: wine_article_path(@wine_article2.id)).click
        # ワイン記事2の詳細ページに移動した事を確認する
        expect(current_path).to eq wine_article_path(@wine_article2.id)
        # いいねするのリンクをクリックするとモデルのカウントが１上がる事を確認する
        expect { click_on 'いいねする' }.to change { Favorite.count }.by(1)
        # いいね数が1になっている事を確認する
        expect(page).to have_content('いいね数： 1')
        # いいねを解除するをクリックするとモデルのカウントがカウントが1下がる事を確認する
        expect { click_on 'いいねを解除する' }.to change { Favorite.count }.by(-1)
        # いいね数が0になっていることを確認する
        expect(page).to have_content('いいね数： 0')
      end
    end
  end
end
