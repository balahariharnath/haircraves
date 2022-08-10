class AddServicesToAppointment < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :service_ids, :string, array: true, default: []
  end
end
