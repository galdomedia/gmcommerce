class PropertyTypesController < ApplicationController
  def index
    @property_types = PropertyType.all
  end
  
  def show
    @property_type = PropertyType.find(params[:id])
    @products = @property_type.products.available
  end
end
