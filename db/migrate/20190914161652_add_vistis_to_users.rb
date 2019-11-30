class AddVistisToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :visits_count, :integer, default: 1
    add_column :users, :last_visit, :datetime, null: true

    User.all.each do |user|
      orders = user.orders
      user.update(visits_count: orders.size, last_visit: orders.last ? orders.last.created_at : user.created_at)
    end
  end
end
