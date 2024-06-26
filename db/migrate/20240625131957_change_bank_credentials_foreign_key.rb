class ChangeBankCredentialsForeignKey < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing foreign key and column
    remove_index :bank_credentials, :employee_id
    remove_column :bank_credentials, :employee_id

    # Add new foreign key to users table as employee_id
    add_reference :bank_credentials, :employee, foreign_key: { to_table: :users }
  end
end
