class Admin::ProducersController < Admin::AdminController
  def index
    @search = Producer.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @producers =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @producer = Producer.find(params[:id])
  end
  
  def new
    @producer = Producer.new
  end
  
  def create
    @producer = Producer.new(params[:producer])
    if @producer.save
      flash[:notice] = t('producers.created')
      redirect_to admin_producer_url(@producer)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @producer = Producer.find(params[:id])
  end
  
  def update
    @producer = Producer.find(params[:id])
    if @producer.update_attributes(params[:producer])
      flash[:notice] = t('producers.updated')
      redirect_to admin_producer_url(@producer)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = t('producers.destroyed')
    redirect_to admin_producers_url
  end
end
