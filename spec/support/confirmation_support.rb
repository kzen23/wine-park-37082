module ConfirmaitonSupport
  def edit_confirmation(_wine_article)
    expect(find('#wine_article_image').value).to eq('')
    expect(find('#wine_article_wine_name').value).to eq(@wine_article1.wine_name)
    expect(find('#wine_article_wine_name_kana').value).to eq(@wine_article1.wine_name_kana)
    expect(find('#wine_article_wine_type_id').value.to_i).to eq(@wine_article1.wine_type_id)
    expect(find('#wine_article_wine_taste_id').value.to_i).to eq(@wine_article1.wine_taste_id)
    expect(find('#wine_article_wine_price').value.to_i).to eq(@wine_article1.wine_price)
    expect(find('#wine_article_wine_shop').value).to eq(@wine_article1.wine_shop)
    expect(find('#wine_article_title').value).to eq(@wine_article1.title)
    expect(find('#wine_article_comment').value).to eq(@wine_article1.comment)
  end

  def input_edit_confirmation(_wine_article)
    expect(page).to have_selector("img[src$='test_wine2.jpeg']")
    expect(@wine_article1.reload.wine_name).to eq(@wine_article1.wine_name)
    expect(@wine_article1.reload.wine_name_kana).to eq(@wine_article1.wine_name_kana)
    expect(@wine_article1.reload.wine_type.name).to eq(@wine_article1.wine_type.name)
    expect(@wine_article1.reload.wine_taste.name).to eq(@wine_article1.wine_taste.name)
    expect(@wine_article1.reload.wine_price).to eq(@wine_article1.wine_price)
    expect(@wine_article1.reload.wine_shop).to eq(@wine_article1.wine_shop)
    expect(@wine_article1.reload.title).to eq(@wine_article1.title)
    expect(@wine_article1.reload.comment).to eq(@wine_article1.comment)
  end

  def input_edit_confirmation2
    expect(page).to have_selector("img[src$='test_wine2.jpeg']")
    expect(@wine_article1.reload.wine_name).to eq(@wine_article1.wine_name)
    expect(@wine_article1.reload.wine_name_kana).to eq(@wine_article1.wine_name_kana)
    expect(@wine_article1.reload.wine_type.name).to eq(@wine_article1.wine_type.name)
    expect(@wine_article1.reload.wine_taste.name).to eq(@wine_article1.wine_taste.name)
    expect(@wine_article1.reload.wine_price).to eq(@wine_article1.wine_price)
    expect(@wine_article1.reload.wine_shop).to eq(@wine_article1.wine_shop)
    expect(@wine_article1.reload.title).to eq(@wine_article1.title)
    expect(@wine_article1.reload.comment).to eq(@wine_article1.comment)
  end

  def input_edit_confirmation3
    expect(page).to have_selector("img[src$='test_wine.jpeg']")
    expect(@wine_article1.reload.wine_name).to eq(@wine_article1.wine_name)
    expect(@wine_article1.reload.wine_name_kana).to eq(@wine_article1.wine_name_kana)
    expect(@wine_article1.reload.wine_type.name).to eq(@wine_article1.wine_type.name)
    expect(@wine_article1.reload.wine_taste.name).to eq(@wine_article1.wine_taste.name)
    expect(@wine_article1.reload.wine_price).to eq(@wine_article1.wine_price)
    expect(@wine_article1.reload.wine_shop).to eq(@wine_article1.wine_shop)
    expect(@wine_article1.reload.title).to eq(@wine_article1.title)
    expect(@wine_article1.reload.comment).to eq(@wine_article1.comment)
  end

  def input_show_confirmation(_wine_article)
    expect(page).to have_selector("img[src$='test_wine.jpeg']")
    expect(page).to have_content(@wine_article1.wine_name)
    expect(page).to have_content(@wine_article1.wine_name_kana)
    expect(page).to have_content(@wine_article1.wine_type.name)
    expect(page).to have_content(@wine_article1.wine_taste.name)
    expect(page).to have_content(@wine_article1.wine_price)
    expect(page).to have_content(@wine_article1.wine_shop)
    expect(page).to have_content(@wine_article1.title)
    expect(page).to have_content(@wine_article1.comment)
  end

  def input_show_confirmation2(_wine_article)
    expect(page).to have_selector("img[src$='test_wine.jpeg']")
    expect(page).to have_content(@wine_article2.wine_name)
    expect(page).to have_content(@wine_article2.wine_name_kana)
    expect(page).to have_content(@wine_article2.wine_type.name)
    expect(page).to have_content(@wine_article2.wine_taste.name)
    expect(page).to have_content(@wine_article2.wine_price)
    expect(page).to have_content(@wine_article2.wine_shop)
    expect(page).to have_content(@wine_article2.title)
    expect(page).to have_content(@wine_article2.comment)
  end

  def input_index_confirmation(_wine_article)
    expect(page).to have_selector("img[src$='test_wine2.jpeg']")
    expect(page).to have_content(@wine_article1.title)
    expect(page).to have_content(@wine_article1.wine_price)
    expect(page).to have_content(@wine_article1.user.nickname)
  end

  def input_index_confirmation2(_wine_article)
    expect(page).to have_selector("img[src$='test_wine.jpeg']")
    expect(page).to have_content(@wine_article1.title)
    expect(page).to have_content(@wine_article1.wine_price)
    expect(page).to have_content(@wine_article1.user.nickname)
  end

  def exist_confirmation(_wine_article)
    expect(page).to have_no_selector("img[src$='test_wine.jpeg']")
    expect(page).to have_no_content(@wine_article1.title)
    expect(page).to have_no_content(@wine_article1.wine_price)
    expect(page).to have_no_content(@wine_article1.user.nickname)
  end

  def exist_confirmation2(_wine_article)
    expect(page).to have_no_selector("img[src$='test_wine.jpeg']")
    expect(page).to have_no_content(@wine_article2.title)
    expect(page).to have_no_content(@wine_article2.wine_price)
    expect(page).to have_no_content(@wine_article2.user.nickname)
  end
end
