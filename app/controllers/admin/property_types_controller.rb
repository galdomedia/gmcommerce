class Admin::PropertyTypesController < Admin::AdminController
  def index
    @search = PropertyType.search(params[:search])
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
      flash[:notice] = t('property_types.created')
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
      flash[:notice] = t('property_types.updated')
      redirect_to admin_property_type_url(@property_type)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @property_type = PropertyType.find(params[:id])
    @property_type.destroy
    flash[:notice] = t('property_types.destroyed')
    redirect_to admin_property_types_url
  end
  
  def reorder
    @property_types = PropertyType.all
  end
  
  def sort
    params[:property_types].each_with_index do |id, index|
      PropertyType.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing=>true
  end
end
