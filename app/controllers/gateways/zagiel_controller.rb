class Gateways::ZagielController < Gateways::PaymentsController
  def new
    @config = Payments.load_settings_for "zagiel"
    @order = Order.find_by_number_and_secret params[:number], params[:key]
    @contact = @order.billing_contact
    
  end
  
  def success
    #redirect_to success_payment_url(:order_id=>params[:zamowienie_id])
    @order = Order.find_by_number params[:zamowienie_id]
    Notifier.deliver_order_confirmation(@order)
    session[:order_number] = nil
  end

  def failed
    #redirect_to failed_payment_url(:order_id=>params[:zamowienie_id], :error_code=>params[:error], :gateway=>'zagiel')
  end
  
  
end