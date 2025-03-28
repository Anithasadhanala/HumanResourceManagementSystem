class CreateEmployeeSupervisors < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_supervisors do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.references :supervisor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
