class PaymentsController < Gateways::PaymentsController

  def new
    @gateways = Gateway.active.all
    if @gateways.length == 1
      gateway = @gateways.first
      return redirect_to(:controller=>"gateways/#{gateway.ident}", :action=>"new", :key=>params[:key], :number=>params[:number])
    end
  end

  def success
    if params[:order_id] == session[:order_number]
      @order = Order.find_by_number session[:order_number]
      session[:order_number] = nil
    else
      flash[:warning] = 'Invalid call'
      redirect_to root_url
    end
  end

  def failed
    @gateway = Gateway.find_by_ident params[:gateway]
    @error_code = params[:error_code].to_i
    @error = t("gmcommerce.gateways.#{@gateway.ident}.error_codes.e#{@error_code}")
  end


end
