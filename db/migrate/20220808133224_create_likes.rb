class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes, id: false do |t|
      t.references :user
      t.references :post
    end
  end
end
