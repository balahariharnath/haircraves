class CreateServiceFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :service_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stylist, :foreign_key => {to_table: :users}

      t.timestamps
    end
  end
end
