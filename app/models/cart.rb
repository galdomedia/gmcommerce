class Cart
  attr_reader :items, :shipment
  attr_accessor :payment_id

  def initialize
    @items = []
    @payment_id = "1"
    @shipment = nil
  end
  
  def add_product(product, quantity = 1, product_variation=nil)
    current_item = @items.find {|item| item.product == product and item.variation==product_variation}
    if current_item
      quantity.times {current_item.increment_quantity}
    else
      ci = CartItem.new(product, product_variation)
      @items << ci
      current_item = @items.find {|item| item.product == product and item.variation==product_variation}
      (quantity - 1).times {current_item.increment_quantity}
    end
  end

  def subtract_product(product, product_variation=nil)
    current_item = @items.find {|item| item.product == product and item.variation==product_variation}
    if current_item
      current_item.decrement_quantity
    end
  end

  def delete_product(product, product_variation=nil)
    current_item = @items.find {|item| item.product == product and item.variation==product_variation}
    if current_item
      @items.delete(current_item)
    end
  end

  def set_quantity(product, quantity, product_variation=nil)
    current_item = @items.find {|item| item.product == product and item.variation==product_variation}
    if current_item
      current_item.set_quantity(quantity)
    end
  end

  def set_shipment(shipment)
    @shipment = shipment
  end

  def total_price
    @items.sum { |item| item.price }.to_f
  end
  alias :total_value :total_price

  def total_price_with_gifts_and_discounts
    normal_products_value = self.total_value_without_gifts
    gifts_value = @items.sum { |item| item.product.is_gift? ? item.price : 0.0}.to_f
    gift_discount_value = GiftDiscount.get_discount_for_cart_value(normal_products_value)
    gifts_value -= gift_discount_value
    gifts_value = 0.0 if gifts_value < 0.0
    normal_products_value + gifts_value
  end

  def total_value_without_gifts
    @items.sum { |item| item.product.is_gift? ? 0.0 : item.price}.to_f
  end

  def total_price_with_delivery
    total = self.total_price_with_gifts_and_discounts
    unless @shipment.blank?
      total+=@shipment.cost if total < @shipment.free_from_cart_value
    end
    total
  end

  def shipment_name
    @shipment.name if @shipment
  end

  def shipment_cost
    unless @shipment.blank?
      self.total_price_with_gifts_and_discounts < @shipment.free_from_cart_value ? @shipment.cost : 0.0
    end
  end
end
