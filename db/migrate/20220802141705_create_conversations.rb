class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.string :convo
      t.references :appointment
      t.references :user

      t.timestamps
    end
  end
end
