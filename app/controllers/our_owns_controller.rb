class OurOwnsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wine_articles = @user.wine_articles
  end
end
