class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.order(:id)  # ← これを追加！
  end

  def show
    @customer = Customer.find(params[:id])
  end

  # 必要に応じて編集機能も
  # def edit
  #   @customer = Customer.find(params[:id])
  # end

  # def update
  #   @customer = Customer.find(params[:id])
  #   if @customer.update(customer_params)
  #     redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました"
  #   else
  #     render :edit
  #   end
  # end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :email, :is_active)
  end
end
