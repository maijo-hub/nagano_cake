class Public::ItemsController < ApplicationController
  def index
    # 新着順で商品を表示
    @items = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end
end
