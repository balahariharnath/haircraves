class ChangeActiveInAvailabilites < ActiveRecord::Migration[7.0]
  def up
    change_column :availabilities, :active, :boolean, :default => false
    add_reference :availabilities, :user
  end
  def down
    change_column :availabilities, :active, :boolean
    remove_reference :availabilities, :user
  end
end
