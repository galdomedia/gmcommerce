# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery  # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :admin?
  before_filter :find_cart, :except=>:destroy
  before_filter :simulate_order_id

  private

    def admin?
      current_user.is_admin? if current_user
    end
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = t('authlogic.access_danied')
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = t('authlogic.only_for_logged_out')
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def find_cart
      @cart = (session[:cart] ||= Cart.new)
      @cart.set_shipment(Shipment.active.first) if @cart.shipment.blank?
      @cart.set_gateway(Gateway.active.first) if @cart.gateway.blank?
    end
    
    def simulate_order_id
      @simulated_order_id = (Order.maximum('id') || 0) + 1
    end

end
