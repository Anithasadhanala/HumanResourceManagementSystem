class CreatePositionHistory < ActiveRecord::Migration[7.1]
  def change
    create_table :position_histories do |t|
      t.references :employee, foreign_key: { to_table: :users }, null: false
      t.references :from_role, foreign_key: { to_table: :job_positions }, null: false
      t.references :to_role, foreign_key: { to_table: :job_positions }, null: false
      t.string :switch_reason, null: false
      t.string :switch_type,null: false
      t.timestamps
    end
  end
end
