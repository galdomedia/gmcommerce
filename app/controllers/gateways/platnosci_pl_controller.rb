class Gateways::PlatnosciPlController < Gateways::PaymentsController
  require 'digest/md5'
  require 'mechanize'
  def new
    config = Payments.load_settings_for "platnosci_pl"
    @order = Order.find_by_number_and_secret params[:number], params[:key]
    @client_ip = request.remote_ip
    @pos_id = config[:pos_id]
    @pos_auth_key = config[:pos_auth_key]
    @ts = Time.now.to_i
    o = @order
    @amount = (o.order_value + o.shipment_cost) * 100
    @desc = "Order ##{o.number} (id: #{o.id.to_s})"
    @order_id = o.id
    @session_id = @order.secret
    @first_name = @order.billing_contact.first_name
    @last_name = @order.billing_contact.last_name
    sig = "" + @pos_id.to_s + @session_id.to_s + @pos_auth_key.to_s
    sig += @amount.to_s + @desc.to_s + @order_id.to_s + @first_name + @last_name
    #sig += o.billing_address.street + o.billing_address.street_nr + o.billing_address.city + o.billing_address.zip_code.to_s
    #sig += o.billing_address.email + o.billing_address.phone
    sig += @client_ip + @ts.to_s + config[:md5_key_1]
    @k2 = config[:md5_key_1][0..2] 
    @sig = Digest::MD5.hexdigest(sig)
  end

  def status
    config = Payments.load_settings_for "platnosci_pl"
    own_sig = Digest::MD5.hexdigest(""+params[:pos_id]+params[:session_id]+params[:ts]+config[:md5_key_2])
    text = 'FAILS'
    if own_sig.upcase == params[:sig].upcase
      text = 'OK'
      @pos_id = config[:pos_id]
      agent = WWW::Mechanize.new
      ts = Time.now.to_i
      session_id = params[:session_id]
      sig = Digest::MD5.hexdigest(@pos_id + session_id + ts.to_s + config[:md5_key_1])
      reply = agent.post('https://www.platnosci.pl/paygw/UTF/Payment/get/txt', "pos_id" => @pos_id, "session_id"=>session_id, "ts"=>ts, "sig"=>sig)
      y = YAML.load(reply.body)
      if y['status']=='OK'
        @order = Order.find_by_secret session_id
        sig = y['trans_pos_id'].to_s + y['trans_session_id'].to_s +
          y['trans_order_id'].to_s + y['trans_status'].to_s +
          y['trans_amount'].to_s + y['trans_desc'].to_s +
          y['trans_ts'].to_s + config[:md5_key_2]
        amount = @order.price * 100
        payment = Payment.new
        payment.gateway = 'platnosci_pl'
        payment.status = y['trans_status']
        payment.transaction_id = y['trans_id']
        payment.order = @order
        if Digest::MD5.hexdigest(sig).upcase == y['trans_sig'].upcase

          if y['trans_amount'].to_s == amount.to_i.to_s
            status_code = y['trans_status']
            if status_code.to_i == 99 or status_code.to_i == 5
              @order.pay
              @order.save
            end
          else
            text = 'Kwoty si« nie zgadzajˆ'
          end
        else
          text = 'Nie zgadzajˆ si« sumy kontrolne'

        end
        payment.transaction_status = text
        payment.save
      end
    else
      text = 'Invalid SIG'
    end

    render :layout=>false, :text=>text

  end

  def ok
  end

  def failed
  end

end
