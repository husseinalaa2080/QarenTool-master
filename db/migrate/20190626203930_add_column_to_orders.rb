class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :confirmed, :boolean
  end
end
