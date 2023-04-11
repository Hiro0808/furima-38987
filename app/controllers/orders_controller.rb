class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @item = Item.find(params[:item_id])
    if @item.user != current_user && @item.purchase.nil?
      @purchase_delivery = PurchaseDelivery.new
    else
      redirect_to root_path
    end
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_delivery_params)
    if @purchase_delivery.valid?
      @purchase_delivery.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def purchase_delivery_params
    params.require(:purchase_delivery).permit(:post_code, :prefecture_id, :city, :street_address, :building_name, :phone_number,:token).merge(item_id: params[:item_id], user_id: current_user.id)
  end
end