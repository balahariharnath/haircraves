class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :business_name
      t.string :location
      t.string :address
      t.text :about_me
      t.string :first_name
      t.string :last_name
      t.string :year_of_exp
      t.datetime :dob
      t.string :gender
      t.string :phone_number


      t.timestamps
    end
  end
end
