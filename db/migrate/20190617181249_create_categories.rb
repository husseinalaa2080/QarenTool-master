class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :icon
      t.string :name
      t.string :name_en
      t.text :description

      t.timestamps
    end
  end
end
