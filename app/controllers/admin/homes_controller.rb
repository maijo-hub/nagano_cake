class Admin::HomesController < ApplicationController
  # 管理者ログイン必須
  before_action :authenticate_admin!

  def top
    @orders = Order.includes(:customer, :order_details)
    .order(created_at: :desc)
    .page(params[:page])
  end
end
