class AddSheetUrlNameToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :sheet_url_name, :string
  end
end
