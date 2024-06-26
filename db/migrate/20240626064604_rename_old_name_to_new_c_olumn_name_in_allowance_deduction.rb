class RenameOldNameToNewCOlumnNameInAllowanceDeduction < ActiveRecord::Migration[7.1]
  def change
    rename_column :allowance_and_deductions, :type, :compensation_type
  end
end
