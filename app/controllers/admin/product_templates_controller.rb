class Admin::ProductTemplatesController < Admin::AdminController
  def index
    @search = ProductTemplate.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @product_templates =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @product_template = ProductTemplate.find(params[:id])
  end
  
  def new
    @product_template = ProductTemplate.new
  end
  
  def create
    @product_template = ProductTemplate.new(params[:product_template])
    if @product_template.save
      flash[:notice] = "Successfully created product template."
      redirect_to admin_product_template_url(@product_template)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @product_template = ProductTemplate.find(params[:id])
  end
  
  def update
    @product_template = ProductTemplate.find(params[:id])
    if @product_template.update_attributes(params[:product_template])
      flash[:notice] = "Successfully updated product template."
      redirect_to admin_product_template_url(@product_template)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product_template = ProductTemplate.find(params[:id])
    @product_template.destroy
    flash[:notice] = "Successfully destroyed product template."
    redirect_to admin_product_templates_url
  end
end
