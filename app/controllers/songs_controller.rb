class SongsController < ApplicationController
  before_action :load_song, only: :show

  def show
    @lyric = Lyric.new
    @comment = Comment.new
    @favorite = Favorite.new
    # @lyric = @song.lyric.is_accepted
    @comments = Comment.find_comment(@song.id, :Song).order_created_at.page(params[:page]).per 10
    if current_user
      @favorites = current_user.favorites
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def audio_download
    @song = Song.find(params[:id])
    send_file @song.audio.path, :filename => @song.audio_file_name,
      :type => @song.audio_content_type, :disposition => "attachment"
  end

  private
  def load_song
    @song = Song.find_by id: params[:id]
    return if @song
    flash[:danger] = "song not exist"
    redirect_to root_path
  end
end
