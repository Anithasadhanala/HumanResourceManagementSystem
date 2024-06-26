class CreateAllowances < ActiveRecord::Migration[7.1]
  def change
    create_table :allowances do |t|
      t.string :title, null: false
      t.integer :amount, null: false
      t.text :description, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
