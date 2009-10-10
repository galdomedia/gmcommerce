Factory.define :valid_producer , :class => Producer do |c|
  c.name "test"
end

Factory.define :invalid_producer , :class => Producer do |u|
end
