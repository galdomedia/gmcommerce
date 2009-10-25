class Admin::MenuGroupsController < Admin::AdminController
  def index
    @menu_groups = MenuGroup.all
  end
  
  def show
    @menu_group = MenuGroup.find(params[:id])
  end
  
  def new
    @menu_group = MenuGroup.new
  end
  
  def create
    @menu_group = MenuGroup.new(params[:menu_group])
    if @menu_group.save
      flash[:notice] = "Successfully created menu group."
      redirect_to admin_menu_group_url(@menu_group)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @menu_group = MenuGroup.find(params[:id])
  end
  
  def update
    @menu_group = MenuGroup.find(params[:id])
    if @menu_group.update_attributes(params[:menu_group])
      flash[:notice] = "Successfully updated menu group."
      redirect_to admin_menu_group_url(@menu_group)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @menu_group = MenuGroup.find(params[:id])
    @menu_group.destroy
    flash[:notice] = "Successfully destroyed menu group."
    redirect_to admin_menu_groups_url
  end
  
  def reorder
    @menu_groups = MenuGroup.all
  end
  
  def sort
    params[:menu_groups].each_with_index do |id, index|
      MenuGroup.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing=>true
  end
end
