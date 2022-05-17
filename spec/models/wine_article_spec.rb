require 'rails_helper'

RSpec.describe WineArticle, type: :model do
  before do
    @wine_article = FactoryBot.build(:wine_article)
  end

  describe 'ワイン投稿記事の保存' do
    context 'ワイン投稿記事が投稿できる時' do
      it 'すべての値を適切に埋めれば、ワイン記事を投稿できる' do
        expect(@wine_article).to be_valid
      end
      it 'wine_name_kanaが、なくてもワイン記事を投稿できる' do
        @wine_article.wine_name_kana = ""
        expect(@wine_article).to be_valid
      end
    end

    context 'ワイン投稿記事が投稿できない時' do
      it 'imageが空では投稿できない' do
        @wine_article.image = nil
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Image can't be blank")
      end
      it 'wine_nameが空では投稿できない' do
        @wine_article.wine_name = ""
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine name can't be blank")
      end
      it 'wine_type_idが空では投稿できない' do
        @wine_article.wine_type_id = nil
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine type can't be blank")
      end
      it 'wine_taste_idが空では投稿できない' do
        @wine_article.wine_taste_id = nil
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine taste can't be blank")
      end
      it 'wine_priceが空では投稿できない' do
        @wine_article.wine_price = nil
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine price can't be blank")
      end
      it 'wine_shopが空では投稿できない' do
        @wine_article.wine_shop = ""
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine shop can't be blank")
      end
      it 'titleが空では投稿できない' do
        @wine_article.title = ""
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Title can't be blank")
      end
      it 'commentが空では投稿できない' do
        @wine_article.comment = ""
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Comment can't be blank")
      end
      it 'wine_nameは40文字を超えると投稿できない' do
        @wine_article.wine_name = Faker::Lorem.characters(number: 41)
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine name is too long (maximum is 40 characters)")
      end
      it 'wine_shopは40文字を超えると投稿できない' do
        @wine_article.wine_shop = Faker::Lorem.characters(number: 41)
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine shop is too long (maximum is 40 characters)")
      end
      it 'titleは40文字を超えると投稿できない' do
        @wine_article.title = Faker::Lorem.characters(number: 41)
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Title is too long (maximum is 40 characters)")
      end
      it 'commentは200文字を超えると投稿できない' do
        @wine_article.comment = Faker::Lorem.characters(number: 201)
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Comment is too long (maximum is 200 characters)")
      end
      it 'wine_priceは半角数字のみでないと投稿できない' do
        @wine_article.wine_price = "1500円"
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine price is invalid. Input half width characters")
      end
      it 'wine_type_idは半角数字でないと登録できない' do
        @wine_article.wine_type_id = "三"
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine type is invalid. Input half width characters")
      end
      it 'wine_taste_idは半角数字でないと登録できない' do
        @wine_article.wine_taste_id = "４"
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine taste is invalid. Input half width characters")
      end
      it 'wine_type_idの値は1だと投稿できない' do
        @wine_article.wine_type_id = 1
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine type can't be blank")
      end
      it 'wine_taste_idの値は1だと投稿できない' do
        @wine_article.wine_taste_id = 1
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("Wine taste can't be blank")
      end
      it 'ワイン記事はユーザーと紐付いていないと投稿できない' do
        @wine_article.user = nil
        @wine_article.valid?
        expect(@wine_article.errors.full_messages).to include("User must exist")
      end
    end
  end
end
