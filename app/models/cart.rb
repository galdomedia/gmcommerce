class Cart
  attr_reader :items
  attr_accessor :payment_id

  def initialize
    @items = []
    @payment_id = "1"
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

  def total_price
    @items.sum { |item| item.price }.to_f
  end

  def total_price_with_delivery
   total_price
  end
end
