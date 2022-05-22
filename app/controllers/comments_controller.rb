class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @wine_article = WineArticle.find(params[:wine_article_id])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to wine_article_path(@comment.wine_article.id)
    else
      render 'new'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, wine_article_id: params[:wine_article_id])
  end
end
