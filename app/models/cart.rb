class Cart
  include Calculator
  attr_reader :items, :shipment, :gateway
  attr_accessor :payment_id

  def initialize
    @items = []
    @payment_id = "1"
    @shipment = nil
    @gateway = nil
  end
  
  def add_product(product, quantity = 1, product_variation=nil)
    unless product_variation
      if product.have_variations?
        product_variation = product.product_variations.first
      end
    end
    current_item = get_item(product, product_variation)
    if current_item
      quantity.times {current_item.increment_quantity}
    else
      ci = CartItem.new(product, product_variation)
      @items << ci
      current_item = get_item(product, product_variation)
      (quantity - 1).times {current_item.increment_quantity}
    end
    self.total_price_with_gifts_and_discounts
  end

  def subtract_product(product, product_variation=nil)
    current_item = get_item(product, product_variation)
    if current_item
      current_item.decrement_quantity
    end
    self.total_price_with_gifts_and_discounts
  end

  def delete_product(product, product_variation=nil)
    current_item = get_item(product, product_variation)
    if current_item
      @items.delete(current_item)
    end
    self.total_price_with_gifts_and_discounts
  end

  def set_quantity(product, quantity, product_variation=nil)
    current_item = get_item(product, product_variation)
    if current_item
      current_item.set_quantity(quantity)
    end
    self.total_price_with_gifts_and_discounts
  end

  def set_shipment(shipment)
    @shipment = shipment
  end
  
  def get_item(product, product_variation=nil)
    @items.find {|item| item.product == product and item.product_variation==product_variation}
  end
  
  def set_gateway(gateway)
    @gateway = gateway
  end
  
end
