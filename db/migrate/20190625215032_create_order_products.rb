class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      # t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
