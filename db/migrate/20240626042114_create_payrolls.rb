class CreatePayrolls < ActiveRecord::Migration[6.0]
  def change
    create_table :payrolls do |t|
      t.integer :employee_id, null: false
      t.integer :base_payroll, null: false

      t.timestamps
    end

    add_foreign_key :payrolls, :users, column: :employee_id
    add_index :payrolls, :employee_id
  end
end
