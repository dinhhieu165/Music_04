class SongsController < ApplicationController
  def show
    @song = Song.find_by id: params[:id]
    redirect_to root_path unless @song
  end

  def index
    @songs = Song.all
    return unless params[:search]
    @songs = Song.order_by_name
                 .search_by_name(params[:search])
                 .page.params[:page].per Settings.show_limit.per_page
  end
end
