class AddUserInMessages < ActiveRecord::Migration[7.0]
  def up
    add_reference :messages, :sender, foreign_key: {to_table: :users}
  end

  def down
    remove_reference :messages, :sender
  end
end
