class AddDeliveredDateToOrders < ActiveRecord::Migration[7.0]
  def up
    add_column :orders, :delivered_date, :datetime
  end

  def down
    remove_column :orders, :delivered_date
  end
end
