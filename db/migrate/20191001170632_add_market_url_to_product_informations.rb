class AddMarketUrlToProductInformations < ActiveRecord::Migration[5.2]
  def change
    add_column :product_informations, :market_url, :text
  end
end
