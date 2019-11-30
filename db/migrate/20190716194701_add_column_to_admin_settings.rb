class AddColumnToAdminSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_settings, :show_lowest_price, :boolean, default: false
    add_column :admin_settings, :show_saving_percentage, :boolean, default: false
  end
end
