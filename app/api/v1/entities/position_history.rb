class V1::Entities::PositionHistory < Grape::Entity
  expose :id, if: { type: :full }
  expose :employee_id
  expose :from_role_id
  expose :to_role_id
  expose :switch_reason
  expose :switch_type
end
