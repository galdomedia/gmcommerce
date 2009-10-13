Factory.define :valid_shipment , :class => Shipment do |s|
  s.name "test"
  s.cost 10.0
  s.active true
end

Factory.define :invalid_shipment , :class => Shipment do |s|
end
