class Admin::SongsController < Admin::AdminController
  before_action :load_song, only: [:update, :edit, :destroy]
  def new
    @song = Song.new
  end

  def create
    @song = Song.new song_params
    if @song.save
      redirect_to admin_songs_path
      flash[:success] = t("admin.flash.successful",
                           obj: "Song", action: "create")
    else
      flash[:error] = t("admin.flash.failed",
                         obj: "Song", action: "create")
      render :new
    end
  end

  def edit
  end

  def index
    @songs = Song.page(params[:page]).per(10)
    return unless params[:search]
    @songs = song.search(params[:search]).desc_at_create.page(params[:page]).per Setting.show_limit.per_page
  end

  def update
    if @song.update_attributes song_params
      flash[:success] = t("admin.flash.successful", obj: "Song", action: "update")
    else
      flash[:error] = t("admin.flash.failed", obj: "Song", action: "update")
    end
    redirect_to admin_songs_path
  end

  def destroy
    if @song.destroy
      flash[:success] = t("admin.flash.successful", obj: "Song", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "Song", action: "destroy")
    end
    redirect_to admin_songs_path
  end

  private

  def song_params
    params.require(:song).permit :name, :audio, :image, :album_id, :category_id
  end

  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:error] = t("admin.flash.error", obj: "Song", id: params[:id])
    redirect_to admin_songs_path
  end
end
