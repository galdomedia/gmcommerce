class CategoriesController < ApplicationController
  helper :categories
  def index 
    @categories = Category.all
    @product = Product.find(:first, :conditions=>['is_promoted=?', true], :order=>['RAND()'])
  end

  def show
    begin
      @property_types = PropertyType.all
      @category = Category.find(params[:id])
      return redirect_to(category_url(@category),:status=>303) if params[:id]!=@category.to_param
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url
    end
    
    @other_categories = Category.find(:all, :conditions=>['id!=?', @category.id])
    params[:search] ||= {}
    unless params[:property_type_id].blank?
      params[:search][:properties_property_type_id_eq] = params[:property_type_id] 
      params[:search][:properties_property_value_eq] = true
    end
    @search = @category.products.search(params[:search])#.merge({:is_gift_eq=>false}))
    @search.order = "ascend_by_name" unless @search.order
    @products =  @search.paginate(:page => params[:page], :include=>[:properties], :per_page=>50)    
  end

end
