require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント投稿の保存' do
    before do
      @comment = FactoryBot.build(:comment)
      @user = FactoryBot.create(:user)
      @wine_article = FactoryBot.create(:wine_article)
      @comment.user_id = @user.id
      @comment.wine_article_id = @wine_article.id
      sleep 0.1
    end

    context 'コメント投稿保存できるとき' do
      it 'textの値があれば、コメント投稿の保存ができる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿保存できないとき' do
      it 'textの値が空では、コメント投稿の保存ができない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'textの値は、100文字を超えるとコメント投稿の保存ができない' do
        @comment.text = Faker::Lorem.characters(101)
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Text is too long (maximum is 100 characters)')
      end
      it 'コメントはユーザーと紐付いていないと投稿できない' do
        @comment.user_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it 'コメントはワイン記事と紐付いていないと投稿できない' do
        @comment.wine_article_id = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Wine article must exist')
      end
    end
  end
end
