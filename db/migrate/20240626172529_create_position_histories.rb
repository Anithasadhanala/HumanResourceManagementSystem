class CreatePositionHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :position_histories do |t|
      t.references :employee, null: false, foreign_key: { to_table: :users }
      t.references :from_role, null: false, foreign_key: { to_table: :job_positions }
      t.references :to_role, null: false, foreign_key: { to_table: :job_positions }
      t.string :switch_reason, null: false
      t.string :switch_type, null: false

      t.timestamps
    end
  end
end
