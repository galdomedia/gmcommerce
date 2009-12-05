class PaymentsController < Gateways::PaymentsController

  def new
    gateway = @cart.gateway
    session[:cart] = nil
    return redirect_to(:controller=>"gateways/#{gateway.ident}", :action=>"new", :key=>params[:key], :number=>params[:number])
  end

  def success
      @order = Order.find_by_number params[:order_id]
      Notifier.deliver_order_confirmation(@order)
      session[:order_number] = nil
  end

  def failed
    @gateway = Gateway.find_by_ident params[:gateway]
    unless params[:error_code].blank?
    @error_code = params[:error_code].to_i
    @error = t("gmcommerce.gateways.#{@gateway.ident}.error_codes.e#{@error_code}")
    else
      @error = ''
    end
    
  end


end
