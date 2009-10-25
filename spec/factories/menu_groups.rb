Factory.define :valid_menu_group , :class => MenuGroup do |mg|
  mg.name "test"
end

Factory.define :invalid_menu_group , :class => MenuGroup do |mg|
end
