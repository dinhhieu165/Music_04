class Admin::LyricsController < Admin::AdminController
  before_action :load_lyric, only: %i(update, destroy)

  def update
    accepted = params[:lyric][:accepted] == "0" ? false : true
    update_accepted accepted
    if @lyric.update_attributes! lyric_params
      flash[:success] = "Allow song's lyric successfully!!"
    else
      flash[:error] = "Somehting went wrong, can't allow this lyric!"
    end
    redirect_to admin_lyrics_path
  end

  def destroy
    if @lyric.destroy
      flash[:success] = "Destroy lyric successfully"
    else
      flash[:error] = "Can't destroy this lyric, try again!"
    end
    redirect_to admin_lyrics_path
  end

  def index
    @lyrics = Lyric.page(params[:page]).per 10
    return unless params[:search]
    @lyrics = Lyric.search(params[:search]).desc_at_create.page(params[:page]).per 10
  end

  def edit
  end

  private
  def update_accepted accepted
    @lyric.update_attributes accepted: accepted
  end
  def lyric_params
    params.require(:lyric).permit :content, :song_id, :user_id
  end

  def load_lyric
    @lyric = Lyric.find_by id: params[:id]
  end
end
