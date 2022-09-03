class Admin::SalesController < ApplicationController
  http_basic_authenticate_with name: ENV["AUTHENTICATION_USERNAME"], password: ENV["AUTHENTICATION_PASSWORD"]
  def index
    @sales = Sale.all.order(starts_on: :desc)
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(product_params)

    if @sale.save
      redirect_to [:admin, :sales], notice: 'Sale created!'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:sale).permit(
      :name,
      :starts_on,
      :ends_on,
      :percent_off
    )
  end

end
