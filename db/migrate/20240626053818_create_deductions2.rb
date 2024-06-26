class CreateDeductions2 < ActiveRecord::Migration[7.1]
  def change
    create_table :deductions2s do |t|
      drop_table :deductions
      t.timestamps
    end
  end
end
