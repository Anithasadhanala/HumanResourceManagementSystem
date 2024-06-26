class AddIsActiveToLeaves < ActiveRecord::Migration[7.1]
  def change
    add_column :leaves, :is_active, :boolean, null: false, default: true
  end
end
