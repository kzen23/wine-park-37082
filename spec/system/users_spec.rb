require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '適切に情報を入力し、20歳以上ならばユーザー新規登録ができてトップページに移動する' do
      # Basic認証を通過する
      basic_pass root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに新規登録のためのリンクがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      fill_in 'Last name', with: @user.last_name
      fill_in 'First name', with: @user.first_name
      fill_in 'Last name kana', with: @user.last_name_kana
      fill_in 'First name kana', with: @user.first_name_kana
      select '1975', from: 'user_birthday_1i'
      select '6', from: 'user_birthday_2i'
      select '21', from: 'user_birthday_3i'
      # 新規登録ボタンを押すとユーザーモデルのカウントが１上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 遷移したトップページにはログアウトのためのリングがあることを確認する
      expect(page).to have_content('ログアウト')
      # 遷移したトップページには、新規登録とログインのためのリンクはないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '適切に情報を入力しなければ新規登録ページに戻ってくる' do
      # Basic認証を通過する
      basic_pass root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに新規登録のためのリンクがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      fill_in 'Last name', with: ''
      fill_in 'First name', with: ''
      fill_in 'Last name kana', with: ''
      fill_in 'First name kana', with: ''
      select '--', from: 'user_birthday_1i'
      select '--', from: 'user_birthday_2i'
      select '--', from: 'user_birthday_3i'
      # 新規登録ボタンを押してもユーザーモデルのカウントがあがらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq(users_path)
    end
    it '適切に情報を入力しても20歳未満ならばユーザー新規登録ができずにトップページに戻ってくる' do
      # Basic認証を通過する
      basic_pass root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに新規登録のためのリンクがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      fill_in 'Last name', with: @user.last_name
      fill_in 'First name', with: @user.first_name
      fill_in 'Last name kana', with: @user.last_name_kana
      fill_in 'First name kana', with: @user.first_name_kana
      select '2002', from: 'user_birthday_1i'
      select '12', from: 'user_birthday_2i'
      select '31', from: 'user_birthday_3i'
      # 新規登録ボタンを押してもユーザーモデルのカウントがあがらないことを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 遷移したトップページに新規登録とログインのためのリンクがあることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
end

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ユーザーログインできるとき' do
    it '保存されているユーザーの情報を正しく入力すればログインできる' do
      # Basic認証を通過する
      basic_pass root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログインのためのリンクがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページに移動する
      visit new_user_session_path
      # ログインに必要な情報を入力する
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトのリンクがあることを確認する
      expect(page).to have_content('ログアウト')
      # トップページに新規登録とログインのリンクがないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザーログインできないとき' do
    it '保存されているユーザーの情報を正しく入力しないとログインできない' do
      # Basic認証を通過する
      basic_pass root_path
      # トップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログインのためのリンクがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページに移動する
      visit new_user_session_path
      # フォームに情報を入力する
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
