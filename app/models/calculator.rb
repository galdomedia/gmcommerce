module Calculator
  attr_accessor :total_value
  def total_price
    self.items.sum { |item| item.price }.to_f
  end


  def total_price_with_gifts_and_discounts
    normal_products_value = self.total_value_without_gifts
    discounted_products = GiftDiscount.get_discounted_products_number_for_cart_value(normal_products_value)
    for item in self.items
      if item.product.is_gift? and discounted_products > 0
        item.discount_value = item.product_price
        discounted_products -= 1
      end
    end
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
end
