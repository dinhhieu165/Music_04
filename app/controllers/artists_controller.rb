class ArtistsController < ApplicationController
  before_action :load_artist, only: :show
  def show
    @albums = @artist.albums.page(params[:page]).per 10
  end

  private
  def load_artist
    @artist = Artist.find_by id: params[:id]
    return if @artist
    flash[:error] = "Artist not exist!"
    redirect_to root_url
  end
end
