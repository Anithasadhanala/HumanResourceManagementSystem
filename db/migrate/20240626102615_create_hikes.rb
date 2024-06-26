class CreateHikes < ActiveRecord::Migration[7.1]
  def change
    create_table :hikes do |t|
      t.references :employee, foreign_key: { to_table: :users }, null: false
      t.string :reason, null: false
      t.integer :percentage_value, null: false
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
