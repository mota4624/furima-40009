class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]   # ログインしてなければログイン画面へ戻す

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    root_back
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def root_back
    redirect_to root_path if current_user == @item.user || Order.exists?(item_id: @item.id)
  end

  def order_params
    params.require(:order_address).permit(:postalcode, :prefecture, :city, :housenumber, :building, :phone).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
