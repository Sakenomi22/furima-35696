class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

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
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:image, :name, :description, :category_id, :status_id, :judgement_id, :area_id,
                                    :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path if @product.user.id != current_user.id
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
