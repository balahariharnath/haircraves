class ChangeContentInPortfolio < ActiveRecord::Migration[7.0]
  def change
    change_column :portfolios, :content, :text
  end
end
