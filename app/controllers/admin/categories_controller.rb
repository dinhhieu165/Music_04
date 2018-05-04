class Admin::CategoriesController < Admin::AdminController
  before_action :load_category, only: [:update, :edit, :destroy]
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path
      flash[:success] = t("admin.flash.successful", obj: "Category", action: "create")
    else
      flash[:error] = t("admin.flash.failed", obj: "Category", action: "create")
      render :new
    end
  end

  def index
    @categories = Category.page(params[:page]).per(10)
    return unless params[:search]
    @categories = Category.search(params[:search]).desc_at_create.page(params[:page]).per Settings.show_limit.per_page
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t("admin.flash.successful", obj: "Category", action: "update")
    else
      flash[:error] = t("admin.flash.failed", obj: "Category", action: "update")
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t("admin.flash.successful", obj: "Category", action: "destroy")
    else
      flash[:error] = t("admin.flash.failed", obj: "Category", action: "destroy")
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :title
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:error] = t("admin.flash.successful", obj: "Category", id: params[:id])
    redirect_to admin_categories_path
  end
end
