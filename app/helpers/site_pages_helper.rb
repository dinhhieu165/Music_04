module SitePagesHelper
  def all_categories
    Category.load_all
  end
end
