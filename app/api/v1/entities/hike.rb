
  class V1::Entities::Hike < Grape::Entity
    expose :id, if: { type: :full }
    expose :employee_id
    expose :reason
    expose :percentage_value
    expose :is_active
  end




