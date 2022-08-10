class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.float :price
      t.integer :qty
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
