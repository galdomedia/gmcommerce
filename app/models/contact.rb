class Contact < ActiveRecord::Base

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :company_name, :if=>proc{|c| c['is_company']}
  validates_presence_of :email, :if=>proc{|c| c['is_billing']}
  validates_presence_of :phone, :if=>proc{|c| c['is_billing']}
  validates_presence_of :is_billing, :if=>proc{|c| c['is_shipping'].blank? or c['is_shipping']==false}
  validates_presence_of :is_shipping, :if=>proc{|c| c['is_billing'].blank? or c['is_billing']==false}

  attr_accessible :first_name, :last_name, :street, :street_nr, :city, :country, :is_billing, :is_shipping, :zip_code, :email, :phone
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
end
