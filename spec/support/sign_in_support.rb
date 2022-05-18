module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('ログインする')
    expect(current_path).to eq(root_path)
  end

  def input_form(wine_article)
    image_path = Rails.root.join('public/images/test_wine.jpeg')
    attach_file('wine_article[image]', image_path, make_visible: true)
    fill_in 'wine_article_wine_name', with: @wine_article.wine_name
    fill_in 'wine_article_wine_name_kana', with: @wine_article.wine_name_kana
    select "白ワイン", from: 'wine_article_wine_type_id'
    select "辛口", from: 'wine_article_wine_taste_id'
    fill_in 'wine_article_wine_price', with: @wine_article.wine_price
    fill_in 'wine_article_wine_shop', with: @wine_article.wine_shop
    fill_in 'wine_article_title', with: @wine_article.title
    fill_in 'wine_article_comment', with: @wine_article.comment
  end
end