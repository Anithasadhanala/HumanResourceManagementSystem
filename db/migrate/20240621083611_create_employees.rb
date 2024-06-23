class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.references :user, null: false, foreign_key: true
      t.string :user_name, null: false
      t.string :phone, null: false
      t.datetime :hired_at, null: false
      t.string :personal_email, null: false
      t.string :emergency_contact_phone, null: false
      t.string :emergency_contact_name, null: false
      t.string :gender, null: false
      t.references :job_position, null: false, foreign_key: true
      t.integer :experience_in_months, null: false
      t.text :qualifications, null: false
      t.string :employee_type, null: false
      t.string :employment_type, null: false
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
