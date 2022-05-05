class WineArticlesController < ApplicationController
  def index
  end

  def new
    @wine_article = WineArticle.new
  end

  def create
    @wine_article = WineArticle.new(wine_article_params)
    if @wine_article.save
      redirect_to root_path
    else
      render 'new'
    end
  end

    private
    def wine_article_params
      params.require(:wine_article).permit(:image, :wine_name, :wine_name_kana, :wine_price, :wine_shop, :title, :comment, :wine_type_id, :wine_taste_id).merge(user_id: current_user.id)
    end
end
