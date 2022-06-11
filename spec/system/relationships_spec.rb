require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  def basic_auth(path)
    username = ENV['BASIC_AUTH_USER']
    password = ENV['BASIC_AUTH_PASSWORD']
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  before do
    @wine_article1 = create(:wine_article)
    @wine_article2 = create(:wine_article)
  end

  describe 'フォロー・フォロワー機能' do
    context 'フォロー・フォロワーの関係の成立と不成立' do
      it '一人のユーザーがフォローした時に関係が成り立ち、フォローをやめた時に関係がなくなる' do
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
        # フォローするをクリックするとモデルのカウントが１あがることを確認する
        expect { click_on 'フォローする' }.to change { Relationship.count }.by(1)
        # ワイン記事２の詳細ページにいることを確認する
        expect(current_path).to eq wine_article_path(@wine_article2.id)
        # フォロワーをクリックする
        click_on 'フォロワー'
        # ユーザー2のフォロワー一覧ページにいることを確認する
        expect(current_path).to eq(user_followers_path(@wine_article2.user))
        # フォローした自身のニックネーム、フォロー数、フォロワー数があることを確認する
        expect(page).to have_content(@wine_article1.user.nickname)
        expect(page).to have_content('フォロー数：1')
        expect(page).to have_content('フォロワー数：0')
        # ワイン記事１の詳細ページに移動する
        visit wine_article_path(@wine_article1.id)
        # フォローをクリックする
        click_on 'フォロー'
        # ユーザー１のフォロー一覧ページにいることを確認する
        expect(current_path).to eq(user_followings_path(@wine_article1.user.id))
        # フォローしたユーザーのニックネーム、フォロー数、フォロワー数があることを確認する
        expect(page).to have_content(@wine_article2.user.nickname)
        expect(page).to have_content('フォロー数：0')
        expect(page).to have_content('フォロワー数：1')
        # ワイン記事２の詳細ページに移動する
        visit wine_article_path(@wine_article2.id)
        # フォローをやめるをクリックするとモデルのカウントが１下がることを確認する
        expect { click_on 'フォローをやめる' }.to change { Relationship.count }.by(-1)
        # ユーザー２のフォロワー一覧ページに移動する
        visit user_followers_path(@wine_article2.user.id)
        # フォロワーがいないことを確認する
        expect(page).to have_content('ユーザーはいません')
        # ユーザー１のフォロー一覧ページに移動する
        visit user_followings_path(@wine_article1.user.id)
        # フォローしているユーザーがいないことを確認する
        expect(page).to have_content('ユーザーはいません')
      end
    end
    context 'ユーザーとフォロー・フォロワーの関係' do
      it 'フォロー・フォロワー関係が成立していてもどちらかのユーザーの存在がなくなれば関係はなくなる' do
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
        # フォローするをクリックするとモデルのカウントが１あがることを確認する
        expect { click_on 'フォローする' }.to change { Relationship.count }.by(1)
        # ワイン記事２の詳細ページにいることを確認する
        expect(current_path).to eq wine_article_path(@wine_article2.id)
        # フォローしたユーザーがいなくなるとモデルのカウントが１下がる事を確認する
        expect{ @wine_article1.user.destroy }.to change { Relationship.count }.by(-1)
      end
    end
  end
end
