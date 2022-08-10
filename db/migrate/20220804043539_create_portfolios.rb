class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
