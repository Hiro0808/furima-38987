class ItemsController < ApplicationController

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :category_id, :condition_id, :shipping_burden_id, :prefecture_id, :date_of_shipment_id, :image).merge(user_id: current_user.id)
  end
end
