class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show]
  before_action :authenticate_user!, except: [:index,:show]
  before_action :move_to_index, except: [:index, :show]
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
  end

  def edit
  end

  def update
    if current_user == @item.user
      if @item.update(item_params)
        redirect_to item_path(@item)
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :category_id, :condition_id, :shipping_burden_id, :prefecture_id, :date_of_shipment_id, :image).merge(user_id: current_user.id)
  end


  def move_to_index
    unless user_signed_in? && current_user == @item.user
      redirect_to action: :index
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
