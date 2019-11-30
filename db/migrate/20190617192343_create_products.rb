class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :name_en
      t.text :description
      t.string :main_image
      t.references :category, foreign_key: true, null: true

      t.timestamps
    end
  end
end
