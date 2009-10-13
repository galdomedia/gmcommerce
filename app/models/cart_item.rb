class CartItem

  attr_reader :product, :quantity, :variation

  def initialize(product, product_variation=nil)
    @product = product
    @variation = product_variation
    @quantity = 1
  end

  def set_quantity(quantity)
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

  def variation_id
    return nil unless @variation
    @variation.id
  end

  def name
    @product.name
  end

  def price
    return self.product_price * @quantity
  end

  def product_price
    return @variation.price unless @variation.blank?
    return @product.get_price
  end

end
