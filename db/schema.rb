# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_26_042114) do
  create_table "addresses", force: :cascade do |t|
    t.string "d_no", null: false
    t.string "landmark", null: false
    t.string "city", null: false
    t.string "zip_code", null: false
    t.string "state", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_permanent", default: true, null: false
    t.integer "employee_id"
    t.index ["employee_id"], name: "index_addresses_on_employee_id"
  end

  create_table "bank_credentials", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "bank_name", null: false
    t.string "bank_branch", null: false
    t.string "account_number", null: false
    t.string "ifsc_code", null: false
    t.string "bank_branch_code", null: false
    t.string "account_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
    t.index ["employee_id"], name: "index_bank_credentials_on_employee_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "employee_supervisors", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "supervisor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_employee_supervisors_on_employee_id"
    t.index ["supervisor_id"], name: "index_employee_supervisors_on_supervisor_id"
  end

  create_table "employees", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_name", null: false
    t.string "phone", null: false
    t.datetime "hired_at", precision: nil, null: false
    t.string "personal_email", null: false
    t.string "emergency_contact_phone", null: false
    t.string "emergency_contact_name", null: false
    t.string "gender", null: false
    t.integer "job_position_id", null: false
    t.integer "experience_in_months", null: false
    t.text "qualifications", null: false
    t.string "employee_type", null: false
    t.string "employment_type", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["job_position_id"], name: "index_employees_on_job_position_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "employees_supervisors", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "supervisor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "supervisor_id"], name: "index_employees_supervisors_on_employee_id_and_supervisor_id", unique: true
    t.index ["employee_id"], name: "index_employees_supervisors_on_employee_id"
    t.index ["supervisor_id"], name: "index_employees_supervisors_on_supervisor_id"
  end

  create_table "job_histories", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "from_role_id", null: false
    t.integer "to_role_id", null: false
    t.date "switched_at", null: false
    t.string "switch_reason", null: false
    t.string "switch_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_job_histories_on_employee_id"
    t.index ["from_role_id"], name: "index_job_histories_on_from_role_id"
    t.index ["to_role_id"], name: "index_job_histories_on_to_role_id"
  end

  create_table "job_positions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "leave_requests", force: :cascade do |t|
    t.integer "requestee_id", null: false
    t.integer "approver_id", null: false
    t.integer "leave_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "working_days_covered", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_leave_requests_on_approver_id"
    t.index ["leave_id"], name: "index_leave_requests_on_leave_id"
    t.index ["requestee_id"], name: "index_leave_requests_on_requestee_id"
  end

  create_table "leaves", force: :cascade do |t|
    t.string "title", null: false
    t.integer "days_count", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "payrolls", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "base_payroll", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_payrolls_on_employee_id"
  end

  create_table "user_jwt_tokens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "jwt_token", null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_jwt_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "users", column: "employee_id"
  add_foreign_key "bank_credentials", "users", column: "employee_id"
  add_foreign_key "employee_supervisors", "users", column: "employee_id"
  add_foreign_key "employee_supervisors", "users", column: "supervisor_id"
  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "job_positions"
  add_foreign_key "employees", "users"
  add_foreign_key "employees_supervisors", "users", column: "employee_id"
  add_foreign_key "employees_supervisors", "users", column: "supervisor_id"
  add_foreign_key "job_histories", "employees"
  add_foreign_key "job_histories", "job_positions", column: "from_role_id"
  add_foreign_key "job_histories", "job_positions", column: "to_role_id"
  add_foreign_key "leave_requests", "leaves", column: "leave_id"
  add_foreign_key "leave_requests", "users", column: "approver_id"
  add_foreign_key "leave_requests", "users", column: "requestee_id"
  add_foreign_key "payrolls", "users", column: "employee_id"
  add_foreign_key "user_jwt_tokens", "users"
end
