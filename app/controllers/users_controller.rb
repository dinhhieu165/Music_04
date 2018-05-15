class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :correct_user, except: %i(index create new)

  def new
    @user = User.new
  end

  def show
    @favorites = @user.favorites.page(params[:page])
      .per 10
  end

  def create
    @user = User.new_with_session user_params, session
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Check your email"
      redirect_to root_url
      session[:user_attributes] = []
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Deleted user"
    else
      flash[:danger] = "Deleted failed"
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = "User not exist"
    redirect_to root_url
  end
end
