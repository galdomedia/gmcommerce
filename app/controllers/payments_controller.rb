class PaymentsController < Gateways::PaymentsController
  
  def new
    @gateways = Gateway.active.all
    if @gateways.length == 1
      gateway = @gateways.first
      return redirect_to(:controller=>"gateways/#{gateway.ident}", :action=>"new", :key=>params[:key], :number=>params[:number])
    end
  end

  def ok
  end

  def failed
  end


end
