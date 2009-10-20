class Gateways::PlatnosciPlController < Gateways::PaymentsController
  require 'digest/md5'
  require 'mechanize'
  def new
    config = Payments.load_settings_for "platnosci_pl"
    @order = Order.find_by_number_and_secret params[:number], params[:key]
    session[:order_number] ||= @order.number
    @client_ip = request.remote_ip
    @pos_id = config[:pos_id]
    @pos_auth_key = config[:pos_auth_key]
    @ts = Time.now.to_i
    o = @order
    @amount = (o.order_value + o.shipment_cost) * 100
    @desc = "Order #{o.number}"
    @order_id = o.number
    @session_id = @order.secret
    @first_name = @order.billing_contact.first_name
    @last_name = @order.billing_contact.last_name
    @k2 = config[:md5_key_1][0..2]
  end

  def status
    config = Payments.load_settings_for "platnosci_pl"
    own_sig = Digest::MD5.hexdigest(""+params[:pos_id]+params[:session_id]+params[:ts]+config[:md5_key_2])
    text = 'OK'
    if own_sig.upcase == params[:sig].upcase
      text = 'OK'
      @pos_id = config[:pos_id]
      agent = WWW::Mechanize.new
      ts = Time.now.to_i
      session_id = params[:session_id]
      sig = Digest::MD5.hexdigest(@pos_id.to_s + session_id.to_s + ts.to_s + config[:md5_key_1])
      reply = agent.post('https://www.platnosci.pl/paygw/UTF/Payment/get/txt', "pos_id" => @pos_id, "session_id"=>session_id, "ts"=>ts, "sig"=>sig)
      y = YAML.load(reply.body)
      if y['status']=='OK'
        @order = Order.find_by_secret session_id
        if @order
          amount = (@order.order_value + @order.shipment_cost) * 100
          sig = ""+@pos_id.to_s + session_id.to_s +
            @order.number.to_s + y['trans_status'].to_s +
            amount.to_i.to_s + y['trans_desc'].to_s +
            y['trans_ts'].to_s + config[:md5_key_2]


          payment = Payment.new
          payment.gateway = 'platnosci_pl'
          payment.status = y['trans_status']
          payment.transaction_id = y['trans_id']
          payment.order = @order
          if Digest::MD5.hexdigest(sig).upcase == y['trans_sig'].upcase
            status_code = y['trans_status']
            if status_code.to_i == 99
              @order.pay
              @order.save
            end
          else
            text = 'Nie zgadzajˆ si« sumy kontrolne'

          end
          payment.transaction_status = text
          payment.save
        else
          text = 'Non-existing order'
        end
      end
    else
      text = 'Invalid SIG'
    end
    render :layout=>false, :text=>text
  end

  def success
    redirect_to success_payment_url(:order_id=>params[:order_id])
  end

  def failed
    redirect_to failed_payment_url(:order_id=>params[:order_id], :error_code=>params[:error], :gateway=>'platnosci_pl')
  end

end
