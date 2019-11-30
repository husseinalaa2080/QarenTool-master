class AddColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :super_admin, :boolean, default: false
  end
end
