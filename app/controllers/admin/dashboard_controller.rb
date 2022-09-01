class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["AUTHENTICATION_USERNAME"], password: ENV["AUTHENTICATION_PASSWORD"]
  
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end

# create_table "products", force: :cascade do |t|
#   t.string "name"
#   t.text "description"
#   t.string "image"
#   t.integer "price_cents"
#   t.integer "quantity"
#   t.datetime "created_at", precision: 6, null: false
#   t.datetime "updated_at", precision: 6, null: false
#   t.bigint "category_id"
#   t.index ["category_id"], name: "index_products_on_category_id"
# end