class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.date :booking_date
      t.string :reason_for_cancel
      t.string :status
      t.time :time
      t.boolean :paid
      t.float :sub_total
      t.float :tax
      t.float :total

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
