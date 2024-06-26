class RenameDeductionsFull < ActiveRecord::Migration[7.1]
  def change
    rename_table  :deductions_fulls, :deductions
  end
end
