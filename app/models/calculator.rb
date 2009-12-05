module Calculator
  attr_accessor :total_value, :discounted_products_number
  def total_price
    self.items.sum { |item| item.price }.to_f
  end
  
  

  def total_price_with_gifts_and_discounts
    self.discounted_products_number ||= 0
    normal_products_value = self.total_value_without_gifts
    products_that_give_gifts = self.items.sum { |item| item.product.gives_gifts? ? item.quantity : 0}
    discounted_products = 0
    discounted_products += GiftDiscount.get_number_of_gifts_for_cart_value(normal_products_value, products_that_give_gifts)
    discounted_products += GiftDiscount.get_discounted_products_number_for_cart_value(normal_products_value)
    for item in self.items
      item.discount_value = 0
      if item.product.is_gift? and discounted_products > 0
        forcounter = (discounted_products - item.quantity) >= 0 ? item.quantity : discounted_products
        item.discount_value += (item.product_price*forcounter)
        discounted_products -= (1*forcounter)
        
      end
    end
    self.discounted_products_number = discounted_products
    gifts_value = self.items.sum { |item| item.product.is_gift? ? item.price : 0.0}.to_f
    gift_discount_value = GiftDiscount.get_discount_for_cart_value(normal_products_value)
    gifts_value -= gift_discount_value
    gifts_value = 0.0 if gifts_value < 0.0
    self.total_value = normal_products_value + gifts_value
  end

  def total_value_without_gifts
    self.items.sum { |item| item.product.is_gift? ? 0.0 : item.price}.to_f
  end

  def total_price_with_delivery
    total = self.total_value
    unless self.shipment.blank?
      total+=self.shipment.cost if total < @shipment.free_from_cart_value
    end
    total
  end

  def shipment_name
    self.shipment.name if self.shipment
  end

  def shipment_cost
    unless self.shipment.blank?
      self.total_price_with_gifts_and_discounts < self.shipment.free_from_cart_value ? self.shipment.cost : 0.0
    end
  end
  
  def is_empty?
    self.items.empty?
  end
end
