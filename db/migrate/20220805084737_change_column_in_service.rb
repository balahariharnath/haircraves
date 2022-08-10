class ChangeColumnInService < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :service_category
    add_reference :services, :service_category
    rename_column :services, :service_type, :name
  end
end
