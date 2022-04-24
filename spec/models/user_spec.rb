require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるとき' do
      it "nickname, email, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birthdayに適切な値があれば登録に進める" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "last_nameが空だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "first_nameが空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "last_name_kanaが空だと登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "first_name_kanaが空だと登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it "nicknameが20文字を超えると登録できない" do
        @user.nickname = Faker::Internet.username(specifier: 21)
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 20 characters)")
      end
      it "passwordが6文字を下回ると登録できない" do
        @user.password = "aaa1a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが128文字を超えると登録できない" do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it "passwordは半角英数字が混合していないと登録できない(半角英字のみ)" do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordは半角英数字が混合していないと登録できない(半角数字のみ)" do
        @user.password = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "passwordとpassword_confirmationが一致していないと登録できない" do
        @user.password = "ab1cde"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameは全角(ひらがな、カタカナ、漢字)でないと登録できない" do
        @user.last_name = "Mike"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it "first_nameは全角(ひらがな、カタカナ、漢字)でないと登録できない" do
        @user.first_name = "Birley"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it 'last_name_kanaは全角カタカナでないと登録できない' do
        @user.last_name_kana = "まいく"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it 'first_name_kanaは全角カタカナでないと登録できない' do
        @user.first_name_kana = "baーりぃ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = "test.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
    end
  end
end
