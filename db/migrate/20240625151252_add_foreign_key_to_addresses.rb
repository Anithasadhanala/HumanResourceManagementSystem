class AddForeignKeyToAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_index :addresses, :employee_id
    remove_column :addresses, :employee_id

    # Add new foreign key to users table as employee_id
    add_reference :addresses, :employee, foreign_key: { to_table: :users }
  end
end
