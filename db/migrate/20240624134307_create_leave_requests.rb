class CreateLeaveRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :leave_requests do |t|
      t.references :employee, foreign_key: { to_table: :users }, null: false
      t.references :approval, foreign_key: { to_table: :users }, null: false
      t.references :leave, foreign_key: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :working_days_covered, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
