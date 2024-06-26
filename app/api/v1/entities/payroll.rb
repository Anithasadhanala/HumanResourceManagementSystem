class V1::Entities::Payroll < Grape::Entity
  expose :id, if: { type: :full }
  expose :employee_id
  expose :base_payroll
end
