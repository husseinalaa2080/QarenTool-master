class CreateAdminSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_settings do |t|
      t.boolean :allow_registration, default: true

      t.timestamps
    end
  end
end
