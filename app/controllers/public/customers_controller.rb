class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
   # マイページ表示
   def show
    @customer = current_customer
  end

  # 登録情報編集
  def edit
    @customer = current_customer
  end

  # 更新処理
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_customers_path, notice: "登録情報を更新しました。"
    else
      render :edit
    end
  end

  # 退会確認ページ
  def check
  end

  # 退会処理
  def withdrow
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました。ご利用ありがとうございました。"
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :postal_code, :address,
      :telephone_number, :email
    )
  end
end
