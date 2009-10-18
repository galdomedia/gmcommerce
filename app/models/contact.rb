class Contact < ActiveRecord::Base

  validates_presence_of :first_name
  validates_presence_of :last_name

  attr_accessible :first_name, :last_name, :street, :street_nr, :city, :country, :is_billing, :is_shipping, :zip_code
end
