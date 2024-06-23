class V1::Entities::Department < Grape::Entity
  expose :id,  if: {type: :full}
  expose :name
  expose :description
end

