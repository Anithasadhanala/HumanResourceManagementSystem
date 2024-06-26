class CreateAllowancesAndDeductions < ActiveRecord::Migration[7.1]
  def change
    create_table :allowances_and_deductions do |t|
      t.boolean :is_active, default: true
      t.references :employee, foreign_key: { to_table: :users }
      t.string :type, null: false
      t.boolean :is_deduction, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
