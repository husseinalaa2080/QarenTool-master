class AddActiveToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :active, :boolean, default: true
  end
end
