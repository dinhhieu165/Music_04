class AlbumsController < ApplicationController
  before_action :load_album, only: :show
  def show
    @song = @album.songs.first
    @lyric = @song.lyrics.is_accepted
    @favorite = Favorite.new
    @comment = Comment.new
    @comments = Comment.load_comment(@album.id, :Album).
      order_created_at.page(params[:page]).per(5)
    if current_user
      @favorites = current_user.favorites
    end
  end

  private
  def load_album
    @album = Album.find_by id: params[:id]
    return if @album
    flash[:error] = "Album not exist!"
    redirect_to root_path
  end
end
