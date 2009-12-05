# == Schema Information
#
# Table name: settings
#
#  id          :integer         not null, primary key
#  label       :string(255)
#  identifier  :string(255)     not null
#  description :text
#  field_type  :string(255)     default("string"), not null
#  value       :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Setting < ActiveRecord::Base
  validates_presence_of :label, :identifier
  #  validates_uniqueness_of :label
  validates_uniqueness_of :identifier

  # Story any kind of object in the value field.
  # This is nice, but you should also make it editable through admin/settings
  serialize :value

  after_save :extract_to_configatron

  attr_accessible :label, :identifier, :description, :field_type, :value

  def self.load(identifier)
    identifier = identifier.to_s if identifier.is_a?(Symbol)
    
    find_by_identifier!(identifier)
  end
  
  # Return the value for a setting
  def self.get(identifier)
    ret = configatron.settings[identifier.to_sym]
    return ret unless ret.nil?

    begin
      setting = Setting.load(identifier)
    rescue
      setting = nil
    end
    
    if setting.nil?
      return ""
    else
      return setting.extract_value
    end
  end

  def extract_value
    return (value == "t" ? true : false) if field_type == "boolean"
    return value.to_i if field_type == "integer"
    return value.to_f if field_type == "float"
    return value
  end

  def self.extract_all_to_configatron
    configatron.settings = {}
    Setting.all.each do |s|
      configatron.settings.merge!({s.identifier.to_sym => s.extract_value})
    end
  end

  def self.create_setting_for_required_field(field)
    create(:value => "f", :field_type => "boolean", :identifier => "profile_" + field + "_required", :label => "Wymagane pole: #{field}?", :description => "Czy to pole będzie wymagane podczas rejestracji?")
  end

  def self.create_setting_for_required_field_global(field)
    create(:value => "f", :field_type => "boolean", :identifier => "profile_" + field + "_required_global", :label => "Wymagane pole: #{field}?", :description => "Czy to pole będzie wymagane podczas edycji profilu?")
  end

  def self.create_setting_for_field_visible_only_for_logged_in(field)
    create(:value => "f", :field_type => "boolean", :identifier => "profile_" + field + "_for_logged_in", :label => "Widoczne tylko dla zalogowanych pole: #{field}?", :description => "Czy to pole ma być widoczne tylko dla zalogowanych użytkowników?")
  end

  private

  def extract_to_configatron
    Setting.extract_all_to_configatron
  end
end
