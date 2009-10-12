Factory.define :valid_product , :class => Product do |p|
  p.name "test"
end

Factory.define :invalid_product , :class => Product do |p|
end

Factory.define :product_with_wrong_price, :class => Product do |p|
  p.name "test"
  p.price "ala"
end

Factory.define :product_book, :class => Product do |p|
  p.name "Thinking in Rails"
  p.price 19.90
end

Factory.define :product_cd, :class => Product do |p|
  p.name "Rails Metal-i-ca"
  p.price 7.85
end
