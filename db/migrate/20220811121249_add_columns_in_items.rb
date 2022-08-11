class AddColumnsInItems < ActiveRecord::Migration[7.0]
  def up
    add_column :items, :average_rating, :float
    add_column :items, :rating_count, :integer
  end

  def down
    remove_column :items, :average_rating
    remove_column :items, :rating_count
  end
end
