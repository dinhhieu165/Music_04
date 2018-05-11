class CategoriesController < ApplicationController
  def show
    @category = Category.find_by id: params[:id]
    redirect_to root_path unless @category
  end

  def index
    @categories = Category.all
    return unless params[:search]
    @categories = Category.order_by_name
                          .search_by_name(params[:search])
                          .page(params[:page]).per Settings.show_limit.per_page
  end
end
