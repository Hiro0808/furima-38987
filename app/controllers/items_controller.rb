class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
      @item = Item.find(params[:id])
  end
  
  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :category_id, :condition_id, :shipping_burden_id, :prefecture_id, :date_of_shipment_id, :image).merge(user_id: current_user.id)
  end
end
