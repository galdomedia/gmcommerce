class CartsController < ApplicationController


  

  def show
    @available_discount = GiftDiscount.get_discount_for_cart_value(@cart.total_value_without_gifts)
    @shipments = Shipment.active.all
    @gateways = Gateway.active.all
    @payments_settings = {}
    Gateway.active.all.each do |gw|
      @payments_settings[gw.ident] = {:name=>gw.name, :config=>Payments.load_settings_for(gw.ident)}
    end
    @wish_list_items = current_user.wish_list_items.all
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
  
  def change_variation_in
    product = Product.find(params[:id])
    old_variation = ProductVariation.find(params[:old_variation_id])
    new_variation = ProductVariation.find(params[:new_variation_id])
    old_item = @cart.get_item(product, old_variation)
    @cart.delete_product(product, old_variation)
    @cart.add_product(product, old_item.quantity, new_variation)
    
    redirect_to cart_url
  end

  def set_shipment_for
    shipment = Shipment.find(params[:shipment])
    @cart.set_shipment(shipment)
    redirect_to cart_url
  end
  
  def set_gateway_for
    gateway = Gateway.find(params[:gateway])
    @cart.set_gateway(gateway)
    redirect_to cart_url
  end

  

end
