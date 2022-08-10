class CreateJoinTablePostsItems < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_items, id: false do |t|
      t.references :post
      t.references :item
    end
  end
end
