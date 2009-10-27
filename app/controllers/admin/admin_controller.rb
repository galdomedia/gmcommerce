class Admin::AdminController < ApplicationController
  layout "admin"
  #before_filter :require_user
  #before_filter :require_staff
  #before_filter :require_role

  def index

  end

  def require_staff
    access_danied unless current_user.is_staff?
  end

  def require_role
    return true if admin?
    cls = self.class.name.demodulize.gsub("Controller","").tableize
    role = Role.find_by_name(cls)
    access_danied unless current_user.roles.member? role
  end

  def access_danied
    flash[:warning] = t('authlogic.access_danied')
    redirect_to root_url
  end
end
