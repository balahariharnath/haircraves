class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :door_no
      t.string :street
      t.string :city
      t.string :state
      t.string :pincode
      t.references :user

      t.timestamps
    end
  end
end
