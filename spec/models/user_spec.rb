require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '新規登録できるときのUserモデル' do
      it "nickname, email, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birthdayに適切な値があれば登録に進める" do
      end
end
