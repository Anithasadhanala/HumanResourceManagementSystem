class V1::Entities::PositionHistory < Grape::Entity
  expose :id, if: { type: :full }
  expose :employee_id
  expose :joined_at
  expose :job_position_id
  expose :switch_type
end
