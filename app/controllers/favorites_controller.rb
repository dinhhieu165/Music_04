class FavoritesController < ApplicationController
  before_action :load_favorite, only: %i(show destroy)
  def create
    if logged_in?
      @favorite = Favorite.new name: params[:favorite][:name]
      @favorite.user = current_user
      @favorite.save
      @song = Song.find_by id: params[:favorite][:song_id]
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @song = @favorite.songs.first
    @comment = Comment.new
    @comments = Comment.find_comment(@favorite.id, :Favorite).
      order_created_at.page(params[:page]).per 5
    if current_user
      @favorites = current_user.favorites
    end
  end

  def destroy
    @user = @favorite.user
    if @favorite.destroy
      flash[:success] = "Destroy favorite successful"
    else
      flash[:error] = "Can't delete Favorite"
    end
    redirect_to user_path(@user)
  end

  private
  def load_favorite
    @favorite = Favorite.find_by id: params[:id]
    return if @favorite
    flash[:danger] = "favorite not exist"
  end
end
