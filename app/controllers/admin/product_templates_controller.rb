class Admin::ProductTemplatesController < Admin::AdminController
  def index
    @product_templates = ProductTemplate.all
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
