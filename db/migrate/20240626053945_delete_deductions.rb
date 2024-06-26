class DeleteDeductions < ActiveRecord::Migration[7.1]
  def change
    drop_table :deductions2s
  end
end
