require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できるときのUserモデル' do
      it "nickname, email, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birthdayに適切な値があれば登録に進める" do
      end
    end

    context '新規登録できないときのUserモデル' do
      it "nicknameが空だと登録できない" do
      end
      it "emailが空だと登録できない" do
      end
      it "passwordが空だと登録できない" do
      end
      it "last_nameが空だと登録できない" do
      end
      it "first_nameが空だと登録できない" do
      end
      it "last_name_kanaが空だと登録できない" do
      end
      it "first_name_kanaが空だと登録できない" do
      end
      it "birthdayが空だと登録できない" do
      end
      it "nicknameが20文字を超えると登録できない" do
      end
      it "passwordが6文字を下回ると登録できない" do
      end
      it "passwordが128文字を超えると登録できない" do
      end
      it "passwordは半角英数字が混合していないと登録できない(半角英字のみ)" do
      end
      it "passwordは半角英数字が混合していないと登録できない(半角数字のみ)" do
      end
      it "passwordとpassword_confirmationが一致していないと登録できない" do
      end
      it "last_nameは全角(ひらがな、カタカナ、漢字)でないと登録できない" do
      end
      it "first_nameは全角(ひらがな、カタカナ、漢字)でないと登録できない" do
      end
      it 'last_name_kanaは全角カタカナでないと登録できない' do
      end
      it 'first_name_kanaは全角カタカナでないと登録できない' do
      end
      it '重複したemailが存在する場合は登録できない' do
      end
      it 'emailは@を含まないと登録できない' do
      end
    end
  end
end
