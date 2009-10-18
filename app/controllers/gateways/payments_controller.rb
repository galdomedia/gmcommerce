class Gateways::PaymentsController < ApplicationController
  before_filter :check_params, :only=>[:new]


  
  def check_params
    if params[:number].blank? or params[:key].blank?
      flash[:warning] = 'Invalid call'
      redirect_to root_url
    end
  end

end
