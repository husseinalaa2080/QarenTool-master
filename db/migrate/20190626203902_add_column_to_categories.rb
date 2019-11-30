class AddColumnToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :name_in_file, :string
  end
end
