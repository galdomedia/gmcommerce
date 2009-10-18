Factory.define :valid_order , :class => Order do |o|
  o.number "123"
  o.secret "test"
  o.status "temporary"
end

Factory.define :invalid_order , :class => Order do |o|
end
