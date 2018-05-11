class SitePagesController < ApplicationController
  def index
    @categories = Category.load_all
    @songs = Song.order_by_name.page(params[:page])
                               .per Settings.show_limit.song
  end
end
