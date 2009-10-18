Factory.define :valid_contact , :class => Contact do |c|
  c.first_name "test"
  c.last_name "test2"
  c.street "test"
  c.street_nr "2/3w"
  c.zip_code "12345"
  c.city "test"
  c.country "test"
  c.is_shipping true
  c.is_billing true
end

Factory.define :invalid_contact , :class => Contact do |c|
end
