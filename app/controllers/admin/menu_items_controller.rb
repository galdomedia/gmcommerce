class Admin::MenuItemsController < Admin::AdminController
  before_filter :find_related 
  
  def index
    @menu_items = @menu_group.menu_items.all
  end
  
  def show
    @menu_item = @menu_group.menu_items.find(params[:id])
  end
  
  def new
    @menu_item = MenuItem.new
  end
  
  def create
    @menu_item = MenuItem.new(params[:menu_item])
    @menu_item.menu_group = @menu_group
    if @menu_item.save
      flash[:notice] = "Successfully created menu item."
      redirect_to admin_menu_group_menu_item_url(@menu_group, @menu_item)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @menu_item = @menu_group.menu_items.find(params[:id])
  end
  
  def update
    @menu_item = @menu_group.menu_items.find(params[:id])
    if @menu_item.update_attributes(params[:menu_item])
      flash[:notice] = "Successfully updated menu item."
      redirect_to admin_menu_group_menu_item_url(@menu_group, @menu_item)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @menu_item = @menu_group.menu_items.find(params[:id])
    @menu_item.destroy
    flash[:notice] = "Successfully destroyed menu item."
    redirect_to admin_menu_group_menu_items_url(@menu_group)
  end
  
  def reorder
    @menu_items = @menu_group.menu_items.all
  end
  
  def sort
    params[:menu_items].each_with_index do |id, index|
      MenuItem.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing=>true
  end
  
  private
    def find_related
      @menu_group = MenuGroup.find(params[:menu_group_id])
    end
end
