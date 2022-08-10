class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :facebook_url, :string
    add_column :users, :insta_url, :string
    add_column :users, :twitter_url, :string
  end
end
