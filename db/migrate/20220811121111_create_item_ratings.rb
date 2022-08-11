class CreateItemRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :item_ratings do |t|
      t.references :item
      t.references :user
      t.integer :rate

      t.timestamps
    end
  end
end
