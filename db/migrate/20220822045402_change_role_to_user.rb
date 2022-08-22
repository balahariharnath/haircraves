class ChangeRoleToUser < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :role, :integer, :default => 0
    remove_reference :users, :role
  end

  def down
    remove_column :users, :role
    add_reference :users, :role
  end
end
