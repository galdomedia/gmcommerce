Factory.define :valid_product , :class => Product do |p|
  p.name "test"
end

Factory.define :invalid_product , :class => Product do |p|
end

Factory.define :product_with_wrong_price, :class => Product do |p|
  p.name "test"
  p.price "ala"
end
