class AddAverageRatingToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :average_rating, :float
    add_column :users, :rating_count, :integer
  end

  def down
    remove_column :users, :average_rating
    remove_column :users, :rating_count
  end
end
