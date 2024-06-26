class CreateDeductionsFull < ActiveRecord::Migration[7.1]
  def change
    create_table :deductions_fulls do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :amount, null: false
      t.boolean :is_active, default: true, null:  false

      t.timestamps
    end
  end
end
