class CreateRatingOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :rating_orders do |t|
      t.integer :rate
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
