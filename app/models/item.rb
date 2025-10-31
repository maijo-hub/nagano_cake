class Item < ApplicationRecord
  # 商品画像（Active Storage）
  has_one_attached :image
  has_many :cart_items, dependent: :destroy

  # バリデーション
  validates :name, :introduction, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }

  # デフォルトスコープ（新しい順で一覧表示）
  default_scope -> { order(created_at: :desc) }

  # 税込価格を返すメソッド
  def add_tax_price
    (price * 1.1).floor  # floorにすると小数点切り捨て（販売価格で使いやすい）
  end

  # 販売ステータス（is_activeがある前提）
  def active_status
    is_active? ? "販売中" : "販売停止中"
  end
end
