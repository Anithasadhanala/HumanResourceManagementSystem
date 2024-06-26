class V1::Entities::PayrollHistory < Grape::Entity
  expose :id, if: { type: :full }
  expose :payroll_id
  expose :payroll_predicted
  expose :bank_credential_id
end
