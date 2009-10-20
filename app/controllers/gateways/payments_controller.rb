class Gateways::PaymentsController < ApplicationController
  before_filter :check_params, :only=>[:new]


  
  def check_params
    if params[:number].blank? or params[:key].blank?
      flash[:warning] = t('gmcommerce.errors.invalid_call')
      redirect_to root_url
    else
      session[:order_number] ||= nil
    end
  end

end
