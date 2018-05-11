class SitePagesController < ApplicationController
  def index
    @categories = Category.load_all
  end
end
