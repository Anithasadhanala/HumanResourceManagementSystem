class V1::Entities::BankCredential < Grape::Entity
  expose :id, if: { type: :full }
  expose :employee_id
  expose :bank_name
  expose :account_number, if: { type: :full }
  expose :ifsc_code, if: { type: :full }
  expose :bank_branch_code, if: { type: :full }
  expose :account_type
  expose :is_active
end
