class CreatePayrollHistory < ActiveRecord::Migration[7.1]
  def change
    create_table :payroll_histories do |t|
      t.references :payroll, foreign_key: true
      t.integer :payroll_predicted, null: false

      t.timestamps
    end
  end
end
