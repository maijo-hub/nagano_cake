class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def check
    @order = Order.new(order_params)

    # 選択された住所をセット
    if params[:order][:address_option] == "customer"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    end

    @cart_items = current_customer.cart_items
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.status = 0 # 入金待ち
  
    cart_items = current_customer.cart_items
  
    # 商品合計金額
    total = cart_items.sum do |cart_item|
      cart_item.item.with_tax_price * cart_item.amount
    end
  
    @order.total_payment = total + @order.shipping_cost
  
    # ★ 追加：注文個数（CartItem.amount の合計）
    @order.total_quantity = cart_items.sum(:amount)
  
    if @order.save
      # ★ 削除：order_details を作らない
      # current_customer.cart_items.each do |cart_item|
      #   @order.order_details.create!(...)
      # end
  
      cart_items.destroy_all
      redirect_to finish_orders_path
    else
      @cart_items = cart_items
      render :check
    end
  end
  
  
  

  def finish
  end
  
  private

  def order_params
    params.require(:order).permit(
      :payment_method,
      :postal_code,
      :address,
      :name,
    )
  end
  
end
