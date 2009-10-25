Factory.define :valid_menu_item , :class => MenuItem do |mi|
  mi.name "test"
  mi.url "/test"
  mi.menu_group {|m| m.association(:valid_menu_group) }
end

Factory.define :invalid_menu_item , :class => MenuItem do |mi|
end
