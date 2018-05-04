class Admin::ArtistsController < Admin::AdminController
  before_action :load_artist, only: [:update, :edit, :destroy]

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new artist_params
    if @artist.save
      flash[:success] = t("admin.flash.successful", obj: "Artist", action: "create")
      redirect_to admin_artists_path
    else
      flash[:error] = t("admin.flash.failed", obj: "Artist", action: "create")
      render :new
    end
  end

  def index
    @artists = Artist.page(params[:page]).per(10)
    return unless params[:search]
    @artists = Artist.search(params[:search]).desc_at_create.page(params[:page]).per Settings.show_limit.per_page
  end

  def edit
  end

  def update
    if @artist.update_attributes artist_params
      flash[:success] = t("admin.flash.successful", obj: "Artist", action: "update")
    else
      flash[:error] = t("admin.flash.failed", obj: "Artist", action: "update")
    end
    redirect_to admin_artists_path
  end

  def destroy
    if @artist.destroy
      flash[:success] = t("admin.flash.successful", obj: "Artist", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "Artist", action: "destroy")
    end
    redirect_to admin_artists_path
  end

  private

  def artist_params
    params.require(:artist).permit :name
  end

  def load_artist
    @artist = Artist.find_by id: params[:id]
    return if @artist
    flash[:error] = t("admin.flash.error", obj: "Artist", id: params[:id])
    redirect_to admin_artists_path
  end
end
