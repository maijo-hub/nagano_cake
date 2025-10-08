class Admin::HomesController < ApplicationController
  # 管理者ログイン必須
  before_action :authenticate_admin!

  # 管理者トップページ（注文履歴一覧など）
  def top
    # 必要に応じて変数定義（例: @orders = Order.all）
  end
end
