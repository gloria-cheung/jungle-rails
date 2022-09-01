class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["AUTHENTICATION_USERNAME"], password: ENV["AUTHENTICATION_PASSWORD"]
  
  def show
    @product_count = Product.sum(:quantity)
    @category_count = Category.count
  end
end