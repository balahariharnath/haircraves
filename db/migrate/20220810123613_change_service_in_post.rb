class ChangeServiceInPost < ActiveRecord::Migration[7.0]
  def up
    remove_column :posts, :service_name
    add_reference :posts, :service_category
  end

  def down
    add_column :posts, :service_name, :string
    remove_reference :posts, :service_category
  end
end
