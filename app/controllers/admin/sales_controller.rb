class Admin::SalesController < ApplicationController
  def index
    @sales = Sale.all.order(starts_on: :desc)
  end

  def new
  end
end
