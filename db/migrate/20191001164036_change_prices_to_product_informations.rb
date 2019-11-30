class ChangePricesToProductInformations < ActiveRecord::Migration[5.2]
  def change
    rename_table :prices, :product_informations
  end
end
