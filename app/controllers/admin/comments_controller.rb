class Admin::CommentsController < Admin::AdminController
  before_filter :find_related
  
  def index
    @comments = @product.comments.all
  end
  
  def show
    @comment = @product.comments.find(params[:id])
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.product = @product
    if @comment.save
      flash[:notice] = t('comments.created')
      redirect_to admin_product_comment_url(@product,@comment)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @comment = @product.comments.find(params[:id])
  end
  
  def update
    @comment = @product.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = t('comments.updated')
      redirect_to admin_product_comment_url(@product,@comment)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = t('comments.destroyed')
    redirect_to admin_product_comments_url
  end
  private
    def find_related
      @product = Product.find(params[:product_id])
    end
end
