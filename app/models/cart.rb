class Cart
  attr_reader :items
  attr_accessor :payment_id

  def initialize
    @items = []
    @payment_id = "1"
  end
  
  def add_product(product, quantity = 1)
    current_item = @items.find {|item| item.product == product}
    if current_item
      quantity.times {current_item.increment_quantity}
    else
      @items << CartItem.new(product)
      current_item = @items.find {|item| item.product == product}
      (quantity - 1).times {current_item.increment_quantity}
    end
  end

  def subtract_product(product)
    current_item = @items.find {|item| item.product == product}
    if current_item
      current_item.decrement_quantity
    end
  end

  def delete_product(product)
    current_item = @items.find {|item| item.product == product}
    if current_item
      @items.delete(current_item)
    end
  end

  def set_quantity product, quantity
    current_item = @items.find {|item| item.product == product}
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
