class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :account_holder_name
      t.string :account_number
      t.string :routing_number

      t.timestamps
    end
  end
end
