class AddIsActiveToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_active, :boolean, default: true, null: false
  end
end
