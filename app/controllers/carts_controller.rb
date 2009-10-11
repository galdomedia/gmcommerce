class CartsController < ApplicationController

  before_filter :find_cart
 

  def show  
  end

  def destroy
    session[:cart] = nil
    redirect_to cart_url
  end

  def add_product_to
    @cart = find_cart
    product = Product.find(params[:id])
    if params[:quantity]
      begin
        quantity = params[:quantity].to_i
        quantity = 1 if quantity < 1
      rescue
        quantity = 1
      end
    else
      quantity = 1
    end
    @cart.add_product(product, quantity)
    redirect_to cart_url
  end

  def delete_product_in
    @cart = find_cart
    if (params[:id]).to_i == 0
      product = Product.find_by_slug(params[:id])
    else
      product = Product.find(params[:id])
    end
    @cart.delete_product(product)
    redirect_to cart_url
  end

  def set_product_quantity_in
    @cart = find_cart
    if (params[:id]).to_i == 0
      product = Product.find_by_slug(params[:id])
    else
      product = Product.find(params[:id])
    end
    @cart.set_quantity(product, params[:product][:quantity])
    redirect_to cart_url
  end

  private
    def find_cart
      @cart = session[:cart] ||= Cart.new
      @cart
    end

end
