class CartItem

  attr_reader :product, :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def set_quantity quantity
    begin
      @quantity = quantity.to_i if quantity.to_i > 0
    rescue
    end
  end

  def increment_quantity
    @quantity += 1
  end

  def decrement_quantity
    @quantity -= 1 if @quantity > 1
  end

  def id
    @product.id
  end

  def name
    @product.name
  end

  def price
    return @product.price * @quantity
  end

  def product_price
    return @product.price
  end

end
