module SignInSupport
  def sign_in(_user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('ログインする')
    expect(current_path).to eq(root_path)
  end

  def sign_in3(_user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on('ログインする')
  end


  def sign_in_edit(_wine_article)
    visit new_user_session_path
    fill_in 'Email', with: @wine_article1.user.email
    fill_in 'Password', with: @wine_article1.user.password
    click_on('ログインする')
    expect(current_path).to eq(root_path)
  end

  def sign_in2(_wine_article)
    visit new_user_session_path
    fill_in 'Email', with: @wine_article.user.email
    fill_in 'Password', with: @wine_article.user.password
    click_on('ログインする')
    expect(current_path).to eq(root_path)
  end

  def sign_in_edit2(_comment)
    visit new_user_session_path
    fill_in 'Email', with: @comment.user.email
    fill_in 'Password', with: @comment.user.password
    click_on('ログインする')
  end
end
