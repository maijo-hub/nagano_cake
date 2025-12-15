class AddTotalQuantityToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total_quantity, :integer, null: false, default: 0
  end
end
