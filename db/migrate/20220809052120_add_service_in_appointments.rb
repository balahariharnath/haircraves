class AddServiceInAppointments < ActiveRecord::Migration[7.0]
  def up
    remove_column :appointments, :service_ids
  end
  def down
    add_column :appointments, :service_ids, :string, array: true
  end
end
