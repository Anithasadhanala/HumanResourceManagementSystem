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

ActiveRecord::Schema[7.1].define(version: 2024_06_23_085620) do
  create_table "addresses", force: :cascade do |t|
    t.integer "employee_id", null: false
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
    t.index ["employee_id"], name: "index_addresses_on_employee_id"
  end

  create_table "bank_credentials", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "bank_name", null: false
    t.string "bank_branch_place", null: false
    t.text "account_number", null: false
    t.text "ifsc_code", null: false
    t.text "bank_branch_code", null: false
    t.string "account_type", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_bank_credentials_on_employee_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true, null: false
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

  create_table "job_positions", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "employees"
  add_foreign_key "bank_credentials", "employees"
  add_foreign_key "employees", "departments"
  add_foreign_key "employees", "job_positions"
  add_foreign_key "employees", "users"
end
