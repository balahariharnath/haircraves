class RemoveAppointmentFromConversations < ActiveRecord::Migration[7.0]
  def change
    remove_reference :conversations, :appointment
  end
end
