class Notifier < ActionMailer::Base
  default_url_options[:host] = "coconti.com"

  def password_reset_instructions(user)
    subject       "Zmiana hasła"
    from          "Sklep Coconti <#{Setting.get(:contact_email)}>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  def order_confirmation(order)
    subject     "Potwierdzenie zamówienia w sklepie #{Setting.get(:site_name)}"
    from        Setting.get(:contact_email)
    recipients  [order.shipping_contact.email, Setting.get(:contact_email)]
    sent_on     Time.now
    body        :order=>order
  end
  

end
