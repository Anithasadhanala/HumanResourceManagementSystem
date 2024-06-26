class CreateEmployeesSupervisors < ActiveRecord::Migration[7.1]
  def change
    create_table :employees_supervisors do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.references :supervisor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :employees_supervisors, [:employee_id, :supervisor_id], unique: true
  end
end
