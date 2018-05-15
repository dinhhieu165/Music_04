class CategoriesController < ApplicationController
  before_action :load_category, only: :show
  def show
    @songs = @category.songs.page(params[:page]).per 10
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @categories = Category.all
    return unless params[:search]
    @categories = Category.order_by_name
                          .search_by_name(params[:search])
                          .page(params[:page]).per Settings.show_limit.per_page
  end
  private
  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = "Category not found"
    redirect_to root_path
  end
end
