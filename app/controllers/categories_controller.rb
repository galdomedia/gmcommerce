class CategoriesController < ApplicationController
  helper :categories
  def index 
  end

  def show
    begin
      @category = Category.find(params[:id])
      return redirect_to(category_url(@category),:status=>303) if params[:id]!=@category.to_param
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = t('categories.errors.not_found')
      redirect_to root_url
    end
  end

end
