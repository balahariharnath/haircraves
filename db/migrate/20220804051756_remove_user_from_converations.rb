class RemoveUserFromConverations < ActiveRecord::Migration[7.0]
  def change
    remove_reference :conversations, :user
    add_column :conversations, :sender_id, :integer
    add_column :conversations, :receiver_id, :integer
  end
end
