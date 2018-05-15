class RatesController < ApplicationController
  def create
    if logged_in?
      rate = Rate.find_rate current_user, rate_params
      rate.update_attributes rate_params
      reder json: {
        status: :success
      }
    else
      reder json: {
        status: :error
      }
    end
  end

  private
  def rate_params
    params.require(:rate).permit :point, :user_id, :song_id
  end
end
