class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:edit, :update]
  before_action :set_wine_article, only: [:new, :create, :edit, :update]
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to wine_article_path(params[:wine_article_id])
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to wine_article_path(params[:wine_article_id])
    else
      render 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, wine_article_id: params[:wine_article_id])
  end

  def set_wine_article
    @wine_article = WineArticle.find(params[:wine_article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def check_user
    @comment = Comment.find(params[:id])
    redirect_to root_path unless current_user.id == @comment.user_id
  end
end
