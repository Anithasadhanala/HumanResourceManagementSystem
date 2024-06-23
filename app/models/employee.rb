# app/models/employee.rb
class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :job_position
  belongs_to :department
  has_many :addresses
  has_many :bank_credentials

  validates :user_name,:first_name,:last_name, :phone, :hired_at, :personal_email, :emergency_contact_phone, :emergency_contact_name,
            :gender, :department_id,:job_position_id, :user_id,:experience_in_months, :qualifications, :employee_type, :employment_type, presence: true
end
