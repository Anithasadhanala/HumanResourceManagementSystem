class V1::Entities::JobPosition < Grape::Entity
  expose :id,  if: {type: :full}
  expose :title
  expose :description
end


