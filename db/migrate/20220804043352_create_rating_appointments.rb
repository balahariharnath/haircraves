class CreateRatingAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :rating_appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :rate
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
