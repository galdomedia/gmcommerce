class Gmcommerce < ActionMailer::Base
  

  def recommend(product, recipent)
    subject    'Coconti - znajomy poleca Ci produkt'
    recipients recipent
    from       Setting.get(:contact_email)
    sent_on    Time.now

    body       :product => product
  end

  def contact_request(name, email, phone, content)
    subject     "Kontakt ze sklepu #{Setting.get(:site_name)}"
    from        email
    recipients  Setting.get(:contact_email)
    sent_on     Time.now
    body        :name=>name, :phone=>phone, :email=>email, :content=>content
  end

end
