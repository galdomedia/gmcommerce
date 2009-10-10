Factory.define :valid_property_type , :class => PropertyType do |pt|
  pt.name "test"
  pt.identifier "test"
  pt.field_type 1
end

Factory.define :invalid_property_type , :class => PropertyType do |pt|
end
