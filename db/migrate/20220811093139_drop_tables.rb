class DropTables < ActiveRecord::Migration[7.0]
  def up
    drop_table :rating_appointments
    drop_table :rating_orders
  end

  def down
    create_table :rating_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :rate
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
    create_table :rating_orders do |t|
      t.integer :rate
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
