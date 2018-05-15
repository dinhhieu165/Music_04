class Admin::PagesController < Admin::AdminController
  def home
    @songs = Song.desc_at_create.page(params[:page]).per(10)
  end
end
