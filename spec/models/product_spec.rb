require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "saves product when name, price, qty and category is present" do
      @category = Category.new
      @product = Product.new do |p|
        p.name = "tree"
        p.price = 40
        p.quantity = 1
        p.category = @category
      end
      @product.save!

      expect(@product.name).to be_present
    end

    it "validates name to be present" do
      @category = Category.new
      @product = Product.new do |p|
        p.name = nil
        p.price = 40
        p.quantity = 1
        p.category = @category
      end
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "validates price to be present" do
      @category = Category.new
      @product = Product.new do |p|
        p.name = "tree"
        p.price_cents = nil
        p.quantity = 1
        p.category = @category
      end
      @product.save

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    
    it "validates quantity to be present" do
      @category = Category.new
      @product = Product.new do |p|
        p.name = "tree"
        p.price = 40
        p.quantity = nil
        p.category = @category
      end
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates category to be present" do
      @category = Category.new
      @product = Product.new do |p|
        p.name = "tree"
        p.price = 40
        p.quantity = 1
        p.category = nil
      end
      @product.save

      expect(@product.errors.full_messages).to include("Category must exist", "Category can't be blank")
    end
  end

end
