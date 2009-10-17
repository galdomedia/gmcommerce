class Admin::ShipmentsController < Admin::AdminController
  def index
    @search = Shipment.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @shipments =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @shipment = Shipment.find(params[:id])
  end
  
  def new
    @shipment = Shipment.new
  end
  
  def create
    @shipment = Shipment.new(params[:shipment])
    if @shipment.save
      flash[:notice] = "Successfully created shipment."
      redirect_to admin_shipment_url(@shipment)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @shipment = Shipment.find(params[:id])
  end
  
  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update_attributes(params[:shipment])
      flash[:notice] = "Successfully updated shipment."
      redirect_to admin_shipment_url(@shipment)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.destroy
    flash[:notice] = "Successfully destroyed shipment."
    redirect_to admin_shipments_url
  end
end
