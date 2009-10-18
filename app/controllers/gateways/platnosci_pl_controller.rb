class Gateways::PlatnosciPlController < Gateways::PaymentsController
  
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
    @session_id = params[:number]
    sig = "" + @pos_id.to_s + @pay_type.to_s + @session_id.to_s + @pos_auth_key.to_s
    #sig += @amount.to_s + @desc.to_s + @order_id.to_s + o.bill_addr_first_name + o.last_name.to_s
    #sig += o.street + o.street_nr + o.city + o.zip_code.to_s
    #sig += o.mail + o.phone + @client_ip + @ts.to_s + keys[0]
    @k2 = config[:md5_key_1][0,2]
    @sig = Digest::MD5.hexdigest(sig)
  end

  def ok
  end

  def failed
  end

end
