class WineArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :check_user, only: [:destroy, :edit]
  before_action :set_wine_article, only: [:show, :destroy, :edit, :update]

  def index
    @wine_articles = WineArticle.includes(:user).order('created_at DESC')
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

  def show
    @comments = @wine_article.comments.includes(:user)
  end

  def destroy
    @wine_article.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    if @wine_article.update(wine_article_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def wine_article_params
    params.require(:wine_article).permit(:image, :wine_name, :wine_name_kana, :wine_price, :wine_shop, :title, :comment,
                                         :wine_type_id, :wine_taste_id).merge(user_id: current_user.id)
  end

  def check_user
    @wine_article = WineArticle.find(params[:id])
    redirect_to root_path unless current_user.id == @wine_article.user_id
  end

  def set_wine_article
    @wine_article = WineArticle.find(params[:id])
  end
end
