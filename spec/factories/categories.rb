Factory.define :valid_category , :class => Category do |c|
  c.name "test"
end

Factory.define :invalid_category , :class => Category do |c|
end
