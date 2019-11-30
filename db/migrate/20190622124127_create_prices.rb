class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.references :market, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :price, precision: 12, scale: 2

      t.timestamps
    end
  end
end
