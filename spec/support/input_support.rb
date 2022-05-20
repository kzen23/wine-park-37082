module InputSupport
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

  def input_form_edit(wine_article)
    image_path = Rails.root.join('public/images/test_wine2.jpeg')
    attach_file('wine_article[image]', image_path, make_visible: true)
    fill_in 'wine_article_wine_name', with: "Heretat El Padnell"
    fill_in 'wine_article_wine_name_kana', with: "エレタットエルパドゥルエル"
    select 'スパークリングワイン', from: 'wine_article_wine_type_id'
    select '極辛口', from: 'wine_article_wine_taste_id'
    fill_in 'wine_article_wine_price', with: 550
    fill_in 'wine_article_wine_shop', with: "なんでも酒やカクヤス池尻店"
    fill_in 'wine_article_title', with: "超コスパスパークリングワイン！！"
    fill_in 'wine_article_comment', with: "550円なのにこの美味さ！！おススメです！！"
    return wine_article
  end

  def input_form_edit2
    fill_in 'wine_article_wine_name', with: "Heretat El Padnell"
    fill_in 'wine_article_wine_name_kana', with: "エレタットエルパドゥルエル"
    select 'スパークリングワイン', from: 'wine_article_wine_type_id'
    select '極辛口', from: 'wine_article_wine_taste_id'
    fill_in 'wine_article_wine_price', with: 550
    fill_in 'wine_article_wine_shop', with: "なんでも酒やカクヤス池尻店"
    fill_in 'wine_article_title', with: "超コスパスパークリングワイン！！"
    fill_in 'wine_article_comment', with: "550円なのにこの美味さ！！おススメです！！"
  end

  def input_form_edit3
    fill_in 'wine_article_wine_name', with: ""
    fill_in 'wine_article_wine_name_kana', with: ""
    select '--', from: 'wine_article_wine_type_id'
    select '--', from: 'wine_article_wine_taste_id'
    fill_in 'wine_article_wine_price', with: nil
    fill_in 'wine_article_wine_shop', with: ""
    fill_in 'wine_article_title', with: ""
    fill_in 'wine_article_comment', with: ""
  end
end