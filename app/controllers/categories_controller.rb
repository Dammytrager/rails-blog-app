class CategoriesController < ApplicationController

  before_action :set_category, only: [:show]
  before_action :require_admin, only: [:new, :create]

  def index
    @categories = Category.all.paginate(page: params[:page]).order(created_at: :desc)
  end


  def new
    @category = Category.new
  end

  def show
  end

  def create
    @category = Category.create(category_param)

    if @category.errors&.full_messages.empty?
      flash[:notice] = 'Category created successfully'
      redirect_to @category
    else
      render new_category_path
    end
  end

  private

  def category_param
    params.require(:category).permit(:name)
  end

  def set_category
    @category ||= Category.find(params[:id])
  end

  def require_admin
    if !(logged_in? && current_user.user_type_admin?)
      flash[:error] = "Only Admins can perform that action"
      redirect_to categories_path
    end
  end

end
