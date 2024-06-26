class RenameAllowancesAndDeductions < ActiveRecord::Migration[7.1]
  def change
    rename_table  :allowances_and_deductions, :allowance_and_deductions
  end
end
