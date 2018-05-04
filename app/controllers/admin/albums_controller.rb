class Admin::AlbumsController < Admin::AdminController
  before_action :load_album, only: [:update, :edit, :destroy]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new album_params
    if @album.save
      flash[:success] = t("admin.flash.successful", obj: "Album", action: "create")
      redirect_to admin_albums_path
    else
      flash[:error] = t("admin.flash.failed", obj: "Album", action: "create")
      render :new
    end
  end

  def index
    @albums = Album.page(params[:page]).per(10)
    return unless params[:search]
    @albums = Album.search(params[:search]).desc_at_create.page(params[:page]).per Settings.show_limit.per_page
  end

  def edit
  end

  def update
    if @album.update_attributes album_params
      flash[:success] = t("admin.flash.successful", obj: "Album", action: "update")
    else
      flash[:error] = t("admin.flash.failed", obj: "Album", action: "update")
    end
    redirect_to admin_albums_path
  end

  def destroy
    if @album.destroy
      flash[:success] = t("admin.flash.successful", obj: "Album", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "Album", action: "destroy")
    end
    redirect_to admin_albums_path
  end

  private

  def album_params
    params.require(:album).permit :name, :Album_id
  end

  def load_album
    @album = Album.find_by id: params[:id]
    return if @album
    flash[:error] = t("admin.flash.error", obj: "Album", id: params[:id])
    redirect_to admin_albums_path
  end
end
