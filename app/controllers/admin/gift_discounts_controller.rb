class Admin::GiftDiscountsController < Admin::AdminController
  def index
    @search = GiftDiscount.search(params[:search])
    @search.order = "ascend_by_name" unless @search.order
    @gift_discounts =  @search.paginate(:page => params[:page], :include=>[])
  end
  
  def show
    @gift_discount = GiftDiscount.find(params[:id])
  end
  
  def new
    @gift_discount = GiftDiscount.new
  end
  
  def create
    @gift_discount = GiftDiscount.new(params[:gift_discount])
    if @gift_discount.save
      flash[:notice] = "Successfully created gift discount."
      redirect_to admin_gift_discount_url(@gift_discount)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @gift_discount = GiftDiscount.find(params[:id])
  end
  
  def update
    @gift_discount = GiftDiscount.find(params[:id])
    if @gift_discount.update_attributes(params[:gift_discount])
      flash[:notice] = "Successfully updated gift discount."
      redirect_to admin_gift_discount_url(@gift_discount)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @gift_discount = GiftDiscount.find(params[:id])
    @gift_discount.destroy
    flash[:notice] = "Successfully destroyed gift discount."
    redirect_to admin_gift_discounts_url
  end
end
