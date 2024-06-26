class DropEmployeesSupervisorsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :employees_supervisors
  end
end
