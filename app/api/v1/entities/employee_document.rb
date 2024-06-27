class V1::Entities::EmployeeDocument < Grape::Entity
  expose :user_id,  if: { type: :full }
  expose :type
  expose :document_link
  expose :document_number
  expose :issued_at
  expose :expires_at
end