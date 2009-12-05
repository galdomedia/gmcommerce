class Admin::SettingsController < Admin::AdminController
 
  def show
    # Render index.html.erb
  end

  def update
    params[:settings].each do |input|
      setting = Setting.find(input[0])

      value = case(setting.field_type)
      when 'string'      then input[1].to_s
      when 'text'        then input[1].to_s
      when 'integer'   then input[1].to_i
      when 'float'       then input[1].to_f
      when 'boolean'  then (input[1].to_i == 1 ? "t" : "f")
      end

      setting.update_attribute(:value, value)
    end

    flash[:notice] = "Ustawienia zapisane"

    redirect_to admin_setting_url # :action => :index
  end
  
end
