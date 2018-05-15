class Admin::UsersController < Admin::AdminController
  before_action :load_user, only: %i(edit update destroy)

  def new
    @user = User.new
  end

  def index
    @users = User.page(params[:page]).per(10)
    return unless params[:search]
    @users = User.search(params[:search]).desc_at_create.page(params[:page]).per Setting.show_limit.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("admin.flash.successful", obj: "User", action: "create")
    else
      flash[:danger] = t("admin.flash.failed", obj: "Song", action: "create")
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = t("admin.flash.successful", obj: "User", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "User", action: "destroy")
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def check_activated
    if params[:user][:activated] == "0"
      @user.activated = false
    else
      @user.activated = true
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to admin_users_path
    flash[:error] = t("admin.flash.error", obj: "User", id: params[:id])
  end
end
