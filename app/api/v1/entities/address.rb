
    class V1::Entities::Address < Grape::Entity
      expose :id, if: { type: :full }
      expose :employee_id
      expose :d_no
      expose :landmark
      expose :city
      expose :zip_code
      expose :state
      expose :country
      expose :is_permanent
    end

