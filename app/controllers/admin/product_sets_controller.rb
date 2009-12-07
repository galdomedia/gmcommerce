class Admin::ProductSetsController < Admin::AdminController
  def index
    @search = ProductSet.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @product_sets =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @product_set = ProductSet.find(params[:id])
  end
  
  def new
    @product_set = ProductSet.new
  end
  
  def create
    @product_set = ProductSet.new(params[:product_set])
    if @product_set.save
      flash[:notice] = "Successfully created product set."
      redirect_to admin_product_set_url(@product_set)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product_set = ProductSet.find(params[:id])
  end
  
  def update
    @product_set = ProductSet.find(params[:id])
    if @product_set.update_attributes(params[:product_set])
      flash[:notice] = "Successfully updated product set."
      redirect_to admin_product_set_url(@product_set)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product_set = ProductSet.find(params[:id])
    @product_set.destroy
    flash[:notice] = "Successfully destroyed product set."
    redirect_to admin_product_sets_url
  end
end
