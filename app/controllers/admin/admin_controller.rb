class Admin::AdminController < ApplicationController
  layout "admin/layouts/application"
  before_action :logged_in_user
  before_action :authenticate_admin


  private
  def authenticate_admin
    return if current_user.admin
    redirect_to root_path
  end
end
