class Admin::PropertyTypesController < Admin::AdminController
  def index
    @search = PropertyType.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @property_types =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @property_type = PropertyType.find(params[:id])
  end
  
  def new
    @property_type = PropertyType.new
  end
  
  def create
    @property_type = PropertyType.new(params[:property_type])
    if @property_type.save
      flash[:notice] = "Successfully created property type."
      redirect_to admin_property_type_url(@property_type)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @property_type = PropertyType.find(params[:id])
  end
  
  def update
    @property_type = PropertyType.find(params[:id])
    if @property_type.update_attributes(params[:property_type])
      flash[:notice] = "Successfully updated property type."
      redirect_to admin_property_type_url(@property_type)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @property_type = PropertyType.find(params[:id])
    @property_type.destroy
    flash[:notice] = "Successfully destroyed property type."
    redirect_to admin_property_types_url
  end
end
