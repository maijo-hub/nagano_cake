class Item < ApplicationRecord
  # バリデーション
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # 商品画像（Active Storage）
  has_one_attached :image

  # 税込価格メソッド（必要なら）
  def add_tax_price
    (price * 1.1).round
  end
end
