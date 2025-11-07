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
    @order.shipping_cost = 800 # 送料固定(例)
    @order.status = 0          # ✅注文ステータス初期値をセット（入金待ち）
  
    # カート内商品合計金額の算出
    total = current_customer.cart_items.sum do |cart_item|
      cart_item.item.with_tax_price * cart_item.amount
    end
  
    @order.total_payment = total + @order.shipping_cost
  
    if @order.save
      current_customer.cart_items.each do |cart_item|
        @order.order_details.create!(
          item_id: cart_item.item_id,
          price: cart_item.item.with_tax_price,
          amount: cart_item.amount,
          making_status: 0 # ✅製作ステータス初期値（着手不可）
        )
      end
  
      current_customer.cart_items.destroy_all
      redirect_to finish_orders_path
    else
      @order = Order.new(order_params)
      @cart_items = current_customer.cart_items
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
      order_details_attributes: [:item_id, :price, :amount]
    )
  end
  
end
