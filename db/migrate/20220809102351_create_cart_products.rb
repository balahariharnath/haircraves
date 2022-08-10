class CreateCartProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_products do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end
