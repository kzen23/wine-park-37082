class WineArticlesController < ApplicationController
  def index
  end

  def new
    @wine_article = WineArticle.new
  end
end
