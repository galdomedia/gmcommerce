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
      flash[:notice] = "Successfully created option group."
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
      flash[:notice] = "Successfully updated option group."
      redirect_to admin_option_group_url(@option_group)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @option_group = OptionGroup.find(params[:id])
    @option_group.destroy
    flash[:notice] = "Successfully destroyed option group."
    redirect_to admin_option_groups_url
  end
end
