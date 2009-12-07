class ProductSetsController < ApplicationController
  def index
    @product_sets = ProductSet.all
  end
  
  def show
    @product_set = ProductSet.find(params[:id])
  end
end
