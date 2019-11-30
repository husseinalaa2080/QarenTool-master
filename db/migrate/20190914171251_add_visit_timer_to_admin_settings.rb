class AddVisitTimerToAdminSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_settings, :visit_timer, :decimal, precision: 7, scale: 4, default: 6
  end
end
