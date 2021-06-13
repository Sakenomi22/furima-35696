class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @product = Product.find(params[:product_id])
    @purchase_delivery = PurchaseDelivery.new
    move_to_index
  end

  def create
    @product = Product.find(params[:product_id])
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(:postal_code, :area_id, :city, :block, :building, :number).merge(
      user_id: current_user.id, product_id: params[:product_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path if @product.user.id == current_user.id || @product.purchases.present?
  end
end
