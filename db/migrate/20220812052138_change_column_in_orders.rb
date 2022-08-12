class ChangeColumnInOrders < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :status, :integer, using: 'status::integer'
    add_column :orders, :payment_type, :string
    add_column :orders, :payment_detail, :string
    add_reference :orders, :seller, foreign_key: {to_table: :users}
  end

  def down
    change_column :orders, :status, :string
    remove_column :orders, :payment_detail
    remove_column :orders, :payment_type
    remove_reference :orders, :seller
  end
end
