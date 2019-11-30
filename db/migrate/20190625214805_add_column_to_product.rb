class AddColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :lowest_price, :decimal, precision: 6, scale: 2
  end
end
