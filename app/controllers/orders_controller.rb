class OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
    @order.same_address = true
    billing = Contact.new
    billing.is_billing = true
    shipping = Contact.new
    shipping.is_shipping = true

    @order.contacts << billing
    @order.contacts << shipping

    @available_discount = GiftDiscount.get_discount_for_cart_value(@cart.total_value_without_gifts)
  end
  
  def create
    @order = Order.new(params[:order])
    if @order.valid?
      Order.create_new(@order, @cart)
      flash[:notice] = "Successfully created order."
      
      session[:order_number] = @order.number
      redirect_to new_payment_url(:key=>@order.secret, :number=>@order.number)
    else
      render :action => 'new'
    end
  end

  def show
    @order = Order.find_by_number_and_secret(params[:id], params[:key])
  end

  
end
