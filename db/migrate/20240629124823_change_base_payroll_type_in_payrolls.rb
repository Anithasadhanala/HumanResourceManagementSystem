class ChangeBasePayrollTypeInPayrolls < ActiveRecord::Migration[6.0]
  def up
    change_column :payrolls, :base_payroll, :float
  end

  def down
    change_column :payrolls, :base_payroll, :integer # or the original type
  end
end
