class CreateJoinTablePostsusers < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_users, id: false do |t|
      t.references :post
      t.references :user
    end
  end
end
