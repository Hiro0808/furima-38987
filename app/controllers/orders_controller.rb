class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    if @item.user != current_user && @item.purchase.nil?
      @purchase_delivery = PurchaseDelivery.new
    else
      redirect_to root_path
    end
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_delivery_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_delivery_params
    params.require(:purchase_delivery).permit(:post_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(token: params[:token], item_id: @item.id, user_id: current_user.id, price: @item.price)
  end

  def pay_item
    Payjp.api_key = "PAYJP_SECRET_KEY"
    Payjp::Charge.create(
      amount: purchase_delivery_params[:price],
      card: purchase_delivery_params[:token],
      currency: 'jpy'
    )
  end
end