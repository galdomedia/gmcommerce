class Admin::ProducersController < Admin::AdminController
  def index
    @producers = Producer.all
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
      flash[:notice] = "Successfully created producer."
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
      flash[:notice] = "Successfully updated producer."
      redirect_to admin_producer_url(@producer)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = "Successfully destroyed producer."
    redirect_to admin_producers_url
  end
end
