class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:image, :name, :description, :category_id, :status_id, :judgement_id, :area_id,
                                    :delivery_day_id, :price).merge(user_id: current_user.id)
  end
end
