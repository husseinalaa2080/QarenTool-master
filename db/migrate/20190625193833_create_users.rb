class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.string :email

      t.index :name
      t.index :mobile, unique: true
      t.timestamps
    end
  end
end
