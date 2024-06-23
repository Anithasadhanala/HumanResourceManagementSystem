class AddIsActiveToDepartments < ActiveRecord::Migration[7.1]
  def change
    add_column :departments, :is_active, :boolean, default: true, null: false
  end
end
