class CreatePositionhistories < ActiveRecord::Migration[7.1]
  def change
    create_table :positionhistories do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :from_role, null: false, foreign_key: { to_table: :job_positions }
      t.references :to_role, null: false, foreign_key: { to_table: :job_positions }
      t.date :switched_at, null: false
      t.string :switch_reason, null: false
      t.string :switch_type, null: false

      t.timestamps
    end
    end
    end


