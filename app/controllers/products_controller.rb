class ProductsController < ApplicationController
  def show
    begin
      @product = Product.find(params[:id])
      return redirect_to(product_url(@product),:status=>303) if params[:id]!=@product.to_param
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = t('products.errors.product_does_not_exist')
      return redirect_to(root_url)
    end
    respond_to do |format|
      format.html #
      format.pdf  do
        render :pdf => @product.name.parameterize,
               :layout=> "/layouts/pdf",
               :wkhtmltopdf => '/usr/local/bin/wkhtmltopdf'
      end

    end
  end

end
