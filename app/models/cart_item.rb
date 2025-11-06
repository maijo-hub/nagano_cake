class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true
  validates :item_id, uniqueness: { scope: :customer_id }

  # 小計（税込 × 数量）
  def subtotal
    item.with_tax_price * amount
  end
  
end
