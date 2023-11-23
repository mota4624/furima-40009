class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]   # ログインしてなければログイン画面へ戻す

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:itemname, :description, :category_id, :condition_id, :shippingfee_id, :shippingorigin_id,
                                 :deliverytime_id, :price, :image).merge(user_id: current_user.id)
  end
end
