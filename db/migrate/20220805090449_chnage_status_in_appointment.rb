class ChnageStatusInAppointment < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :status, :integer, using: 'status::integer'
  end
end
