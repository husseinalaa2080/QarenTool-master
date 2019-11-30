class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :confirmed_by, :integer
    add_column :orders, :checkout_at, :timestamp
    add_column :orders, :confirmed_at, :timestamp
  end
end
