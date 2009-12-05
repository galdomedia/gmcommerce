class Contact < ActiveRecord::Base
  include RFC822
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :city
  validates_format_of :zip_code, :with=>/^\d{2}\-?\d{3}$/
  validates_presence_of :street
  validates_presence_of :street_nr
  validates_presence_of :company_name, :if=>proc{|c| c['is_company']}
  validates_format_of :vat_code, :if=>proc{|c| c['is_company']}, :with=>/^\d{10}$/
  validates_format_of :regon, :if=>proc{|c| c['is_company']}, :with=>/^\d{9}$/
  validates_presence_of :email, :if=>proc{|c| c['is_billing']}
  
  validates_format_of :email, :with => EmailAddress
  validates_presence_of :phone, :if=>proc{|c| c['is_billing']}
  validates_presence_of :is_billing, :if=>proc{|c| c['is_shipping'].blank? or c['is_shipping']==false}
  validates_presence_of :is_shipping, :if=>proc{|c| c['is_billing'].blank? or c['is_billing']==false}

  attr_accessible :first_name, :last_name, :street, :street_nr, :city, :country, :is_billing, :is_shipping, :zip_code, :email, :phone, :is_company, :company_name, :vat_code, :regon
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
end
