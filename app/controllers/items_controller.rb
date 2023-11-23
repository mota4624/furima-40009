class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]   # ログインしてなければログイン画面へ戻す
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
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

  def show
  end

  def edit
    redirect_to root_path unless current_user == @item.user
    # redirect_to root_path unless 商品が売却済みの場合(商品購入機能実装後に記載予定)
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:itemname, :description, :category_id, :condition_id, :shippingfee_id, :shippingorigin_id,
                                 :deliverytime_id, :price, :image).merge(user_id: current_user.id)
  end
end
