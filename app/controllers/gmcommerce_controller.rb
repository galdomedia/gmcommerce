class GmcommerceController < ApplicationController
  def index
    
  end

  def contact_request
    begin
      unless params[:content].blank?
        if params[:email] =~ EmailAddress
          Gmcommerce::deliver_contact_request(params[:name], params[:email], params[:phone], params[:content])
          flash[:notice] = 'Wiadomoæ zosta¸a wys¸ana'
        else
          flash[:notice] = 'Niepoprawny adres email!'
        end
      else
        flash[:notice] = 'Brak treæci!'
      end
    rescue
      flash[:notice] = 'Wystˆpi¸ b¸ˆd podczas wysy¸ania wiadomoæci'
    end
    redirect_to :action=>"contact"
  end

  def recomend
    if not params[:recipent].blank? and not params[:product_id].blank?
      product = Product.find(params[:product_id])
      if params[:recipent] =~ EmailAddress
        Gmcommerce::deliver_recomend(product, params[:recipent])
      end
      redirect_to product_url(product) and return
    end
    redirect_to root_url
  end

  def markdown
    unless params[:data].blank?
      doc = BlueCloth::new(params[:data])
    else
      doc = ''
    end
    render :text=>doc.to_html, :layout=>false
  end

end
