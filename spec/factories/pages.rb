Factory.define :valid_page , :class => Page do |p|
  p.title "test"
end

Factory.define :invalid_page , :class => Page do |p|
end
