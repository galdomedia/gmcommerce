class ProductsController < ApplicationController
  def show
    begin
      @product = Product.find(params[:id])
      return redirect_to(product_url(@product),:status=>303) if params[:id]!=@product.to_param
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = t('products.errors.product_does_not_exist')
      redirect_to root_url
    end
  end

end