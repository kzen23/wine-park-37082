require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'ワイン投稿記事といいね' do
    before do
      @favorite = create(:favorite)
    end
    context 'ワイン投稿記事が削除された時' do
      it 'ワイン投稿記事が削除されるといいねも同時に削除される' do
        expect { @favorite.wine_article.destroy }.to change { Favorite.count }.by(-1)
      end
    end
  end
end
