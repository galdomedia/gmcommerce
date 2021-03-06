class Admin::ProductsController < Admin::AdminController
  def index
    @search = Product.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @products =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
    unless params[:template].blank?
      @product.fill_values_from_template(ProductTemplate.find(params[:template]))
    end
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = t('products.created')
      redirect_to admin_product_url(@product)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = t('products.updated')
      redirect_to admin_product_url(@product)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = t('products.destroyed')
    redirect_to admin_products_url
  end
  
  def reorder
    @products = Product.all
  end
  
  def sort
    params[:products].each_with_index do |id, index|
      Product.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing=>true
  end
end
