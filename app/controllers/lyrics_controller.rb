class LyricsController < ApplicationController
  def create
    @lyric = Lyric.new lyric_params
    @lyric.user = current_user
    if @lyric.save
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def lyric_params
    params.require(:lyric).permit :content, :song_id
  end
end

