class CreateDeductions < ActiveRecord::Migration[7.1]
  def change
    create_table :deductions do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.string :type, null: false
      t.integer :amount, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
