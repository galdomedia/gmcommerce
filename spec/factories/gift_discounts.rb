Factory.define :valid_gift_discount , :class => GiftDiscount do |gd|
  gd.name "test"
  gd.discount_value 10
  gd.from_cart_value 100
end

Factory.define :invalid_gift_discount , :class => GiftDiscount do |gd|
end
