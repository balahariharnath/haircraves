class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :card_number
      t.string :card_holder_name
      t.string :exp_date
      t.references :user

      t.timestamps
    end
  end
end
