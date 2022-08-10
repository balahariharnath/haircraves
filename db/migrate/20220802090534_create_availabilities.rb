class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.string :day
      t.boolean :active
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
