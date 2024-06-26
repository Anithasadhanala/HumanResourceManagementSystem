class V1::Entities::Leave < Grape::Entity
  expose :id,  if: {type: :full}
  expose :title
  expose :description
  expose :days_count
end


