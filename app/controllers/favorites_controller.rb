class FavoritesController < ApplicationController
  def show
    @wine_article = WineArticle.find(params[:wine_article_id])
    @user = @wine_article.user
    @favorite_wine_articles = @user.favorite_wine_articles
  end

  def create
    favorite = current_user.favorites.build(wine_article_id: params[:wine_article_id])
    favorite.save
    redirect_to wine_article_path(params[:wine_article_id])
  end

  def destroy
    favorite = Favorite.find_by(wine_article_id: params[:wine_article_id], user_id: current_user.id)
    favorite.destroy
    redirect_to wine_article_path(params[:wine_article_id])
  end
end
