module CalculatedItem
  def id
    self.product.id
  end

  def variation_id
    return nil unless self.product_variation
    self.product_variation.id
  end

  def name
    self.product.name
  end

  def price
    self.discount_value ||= 0.0
    return (self.product_price * self.quantity) - self.discount_value
  end

  def product_price
    return self.product_variation.price unless self.product_variation.blank?
    return self.product.get_price
  end
  
end
