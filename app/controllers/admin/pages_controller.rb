class Admin::PagesController < Admin::AdminController
  def index
    @search = Page.search(params[:search])
    @search.order = "ascend_by_title" unless @search.order
    @pages =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = t('pages.created')
      redirect_to admin_page_url(@page)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = t('pages.updated')
      redirect_to admin_page_url(@page)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    unless @page.is_undeleteable?
      @page.destroy
      flash[:notice] = t('pages.destroyed')
    else
      flash[:notice] = t('pages.cant_destroy')
    end
    redirect_to admin_pages_url
  end
end
