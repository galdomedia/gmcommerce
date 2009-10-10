Factory.define :valid_producer , :class => Producer do |p|
  p.name "test"
end

Factory.define :invalid_producer , :class => Producer do |p|
end
