class AddIsActiveToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :is_active, :boolean, default: true, null: false
  end
end
