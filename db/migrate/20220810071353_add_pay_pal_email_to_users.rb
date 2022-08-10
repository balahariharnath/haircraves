class AddPayPalEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pay_pal_email, :string
  end
end
