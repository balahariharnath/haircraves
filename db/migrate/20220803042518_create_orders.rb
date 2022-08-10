class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :qty
      t.float :sub_total
      t.float :charges
      t.float :grand_total
      t.references :item
      t.references :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
