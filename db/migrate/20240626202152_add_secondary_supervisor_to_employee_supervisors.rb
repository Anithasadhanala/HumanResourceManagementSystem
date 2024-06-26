class AddSecondarySupervisorToEmployeeSupervisors < ActiveRecord::Migration[7.1]
  def change
    add_column :employee_supervisors, :secondary_supervisor_id, :integer
    add_foreign_key :employee_supervisors, :users, column: :secondary_supervisor_id
  end
end
