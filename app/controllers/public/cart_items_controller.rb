class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total = @cart_items.sum { |cart_item| cart_item.item.add_tax_price * cart_item.amount }
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: "数量を変更しました"
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path, notice: "商品を削除しました"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました"
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
  
    if @cart_item
      @cart_item.amount += cart_item_params[:amount].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end
  
    if @cart_item.save
      redirect_to cart_items_path, notice: "商品をカートに追加しました"
    else
      redirect_to request.referer, alert: "カートへの追加に失敗しました"
    end
  end 

  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
