class WishListItemsController < ApplicationController

  before_filter :require_user

  def index
    @wish_list_items = current_user.wish_list_items.all
  end
  
  def create
    @wish_list_item = WishListItem.new
    @wish_list_item.user = current_user
    @wish_list_item.product = Product.find(params[:product_id])

    if @wish_list_item.save
      flash[:notice] = "Successfully created wish list item."
      redirect_back_or_default cart_url
    else
      redirect_back_or_default root_url
    end
  end
  
  def destroy
    @wish_list_item = current_user.wish_list_items.find(:first, :conditions=>['product_id=?', params[:product_id]])
    @wish_list_item.destroy
    flash[:notice] = "Successfully destroyed wish list item."
    redirect_to cart_url
  end
end
