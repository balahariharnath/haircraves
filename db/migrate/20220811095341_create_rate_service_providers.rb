class CreateRateServiceProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :rate_service_providers do |t|
      t.integer :rate
      t.references :user, null: false, foreign_key: true
      t.references :stylist, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
