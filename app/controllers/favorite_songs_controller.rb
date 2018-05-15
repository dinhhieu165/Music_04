class FavoriteSongsController < ApplicationController
  before_action :load_favorite_song, only: :destroy
  def create
    @favorite_song = FavoriteSong.new favorite_id: params[:favorite_id], song_id: params[:song_id]
    @favorite = Favorite.find_by id: params[:favorite_id]
    @song = Song.find_by id: params[:song_id]
    @favorite_song.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @favorite = @favorite_song.favorite
    @song = @favorite_song.song
    @favorite_song.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def load_favorite_song
    @favorite_song = FavoriteSong.find_by id: params[:id]
    return if @favorite_song
    flash[:danger] = "Favorite song not exist"
    redirect_to root_path
  end
end
