class AddColumnToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :sheet_name, :string
  end
end
