class Admin::OptionGroupsController < Admin::AdminController
  def index
    @search = OptionGroup.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @option_groups =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @option_group = OptionGroup.find(params[:id])
  end
  
  def new
    @option_group = OptionGroup.new
  end
  
  def create
    @option_group = OptionGroup.new(params[:option_group])
    if @option_group.save
      flash[:notice] = t('option_groups.created')
      redirect_to admin_option_group_url(@option_group)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @option_group = OptionGroup.find(params[:id])
  end
  
  def update
    @option_group = OptionGroup.find(params[:id])
    if @option_group.update_attributes(params[:option_group])
      flash[:notice] = t('option_groups.updated')
      redirect_to admin_option_group_url(@option_group)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @option_group = OptionGroup.find(params[:id])
    @option_group.destroy
    flash[:notice] = t('option_groups.destroyed')
    redirect_to admin_option_groups_url
  end
  
  def reorder
    @option_group = OptionGroup.find(params[:id])
  end
  
  def sort
    @option_group = OptionGroup.find(params[:id])
    params[:options].each_with_index do |id, index|
      Option.update_all(['position=?', index+1], ['id=? and option_group_id=?', id, @option_group.id])
    end
    render :nothing=>true
  end
end
