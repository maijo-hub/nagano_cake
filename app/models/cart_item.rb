class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true
  validates :item_id, uniqueness: { scope: :customer_id }

end
