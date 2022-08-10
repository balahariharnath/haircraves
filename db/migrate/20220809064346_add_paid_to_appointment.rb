class AddPaidToAppointment < ActiveRecord::Migration[7.0]
  def up
    change_column :appointments, :paid, :boolean, default: false
  end

  def down
    change_column :appointments, :paid, :boolean
  end
end
