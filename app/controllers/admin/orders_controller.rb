class Admin::OrdersController < Admin::AdminController
  def index
    @search = Order.search(params[:search])
    @search.order = "descend_by_number" unless @search.order
    @orders =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = t('orders.created')
      redirect_to admin_order_url(@order)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      flash[:notice] = t('orders.updated')
      redirect_to admin_order_url(@order)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = t('orders.destroyed')
    redirect_to admin_orders_url
  end
  
  def cancel
    @order = Order.find(params[:id])
    @order.make_canceled
    @order.save
    redirect_to admin_order_url(@order)
  end
  
  def pay
    @order = Order.find(params[:id])
    @order.pay
    @order.save
    redirect_to admin_order_url(@order)
  end
  
  def send_order
    @order = Order.find(params[:id])
    @order.send_order
    @order.save
    redirect_to admin_order_url(@order)
  end
  
  def deliver
    @order = Order.find(params[:id])
    @order.deliver
    @order.save
    redirect_to admin_order_url(@order)
  end
end
