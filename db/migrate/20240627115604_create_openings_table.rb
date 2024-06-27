class CreateOpeningsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :openings_tables do |t|
      t.references :job_position, null: false, foreign_key: {to_table: :job_positions}
      t.string :required_qualifications, null: false
      t.integer :max_salary, null: false
      t.integer :min_salary, null: false
      t.integer :openings_count, null: false
      t.integer :occupancy_count, null: false
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.integer :employment_type, null: false
      t.timestamps
    end
  end
end
