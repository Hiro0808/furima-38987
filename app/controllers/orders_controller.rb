class OrdersController < ApplicationController
  def index
    @purchase_delivery = PurchaseDelivery.new
    @item = Item.find(params[:item_id])
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
