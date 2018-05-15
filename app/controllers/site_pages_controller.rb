class SitePagesController < ApplicationController
  def index
    @categories = Category.load_all
    @songs = Song.all.limit 10
    @albums = Album.all.limit 10
    @favorite = Favorite.all.limit 10
  end
end
