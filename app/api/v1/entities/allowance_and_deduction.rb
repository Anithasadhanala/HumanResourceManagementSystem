class V1::Entities::AllowanceAndDeduction < Grape::Entity
  expose :id, if: { type: :full }
  expose :employee_id
  expose :compensation_type
  expose :is_deduction
  expose :amount
  expose :is_active
end