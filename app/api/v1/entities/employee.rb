class V1::Entities::Employee < Grape::Entity
  expose :id, if: { type: :full }
  expose :user_name
  expose :first_name
  expose :last_name
  expose :phone
  expose :hired_at
  expose :personal_email
  expose :emergency_contact_phone
  expose :emergency_contact_name
  expose :gender
  expose :experience_in_months
  expose :qualifications
  expose :employee_type
  expose :employment_type
  expose :job_position_id
  expose :department_id
end


