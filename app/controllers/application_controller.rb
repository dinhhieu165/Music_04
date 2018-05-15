class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_locale
  before_action :set_categories

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.please_login"
    redirect_to login_url

  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_categories
    @categories = Category.select(:id, :title)
  end
end
