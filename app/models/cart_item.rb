class CartItem
  include CalculatedItem
  
  attr_reader :product, :quantity, :product_variation
  attr_accessor :discount_value

  def initialize(product, product_variation=nil)
    @product = product
    @product_variation = product_variation
    @quantity = 1
    @discount_value = 0
  end

  def set_quantity(quantity)
    begin
      @quantity = quantity.to_i if quantity.to_i > 0 and quantity.to_i < 10
    rescue
    end
  end

  def increment_quantity
    @quantity += 1
  end

  def decrement_quantity
    @quantity -= 1 if @quantity > 1
  end
  
  

  

end
