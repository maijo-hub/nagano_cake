class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc).page(params[:page]).per(10)
  end
  

  def new
    @item = Item.new(is_active: true) # デフォルト：販売中
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました。"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :is_active)
  end
end
