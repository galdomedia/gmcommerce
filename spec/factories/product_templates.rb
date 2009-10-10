Factory.define :valid_product_template , :class => ProductTemplate do |pt|
  pt.template_name "test" 
end

Factory.define :invalid_product_template , :class => ProductTemplate do |pt|
end
