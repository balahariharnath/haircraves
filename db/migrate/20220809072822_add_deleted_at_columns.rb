class AddDeletedAtColumns < ActiveRecord::Migration[7.0]
  def up
    add_column :addresses, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
    add_column :items, :deleted_at, :datetime
    add_column :cards, :deleted_at, :datetime
    add_column :orders, :deleted_at, :datetime

    add_index :addresses, :deleted_at
    add_index :users, :deleted_at
    add_index :items, :deleted_at
    add_index :cards, :deleted_at
    add_index :orders, :deleted_at
  end

  def down
    remove_index :addresses, :deleted_at
    remove_index :users, :deleted_at
    remove_index :items, :deleted_at
    remove_index :cards, :deleted_at
    remove_index :orders, :deleted_at

    remove_column :addresses, :deleted_at, :datetime
    remove_column :users, :deleted_at, :datetime
    remove_column :items, :deleted_at, :datetime
    remove_column :cards, :deleted_at, :datetime
    remove_column :orders, :deleted_at, :datetime
  end
end
