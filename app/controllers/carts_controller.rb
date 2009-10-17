class CartsController < ApplicationController


  before_filter :find_cart, :except=>:destroy

  def show
    @available_discount = GiftDiscount.get_discount_for_cart_value(@cart.total_value_without_gifts)
  end

  def destroy
    session[:cart] = nil
    redirect_to cart_url
  end

  def add_product_to
    product = Product.find(params[:id])
    product_variation = nil
    product_variation = ProductVariation.find(params[:variation_id]) unless params[:variation_id].blank?
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
    @cart.add_product(product, quantity, product_variation)
    redirect_to cart_url
  end

  def delete_product_in
    product = Product.find(params[:id])
    product_variation = nil
    product_variation = ProductVariation.find(params[:variation_id]) unless params[:variation_id].blank?
    @cart.delete_product(product, product_variation)
    redirect_to cart_url
  end

  def set_product_quantity_in
    product = Product.find(params[:id])
    product_variation = nil
    product_variation = ProductVariation.find(params[:variation_id]) unless params[:variation_id].blank?
    @cart.set_quantity(product, params[:product][:quantity], product_variation)
    redirect_to cart_url
  end

  private
    def find_cart
      @cart = (session[:cart] ||= Cart.new)
    end

end
