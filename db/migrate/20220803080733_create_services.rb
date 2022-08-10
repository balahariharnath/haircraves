class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :service_category
      t.string :service_type
      t.float :price
      t.time :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
