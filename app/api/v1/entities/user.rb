class V1::Entities::User < Grape::Entity
  expose :id,  if: {type: :full}
  expose :email
  expose :role

  expose :employee, using: V1::Entities::Employee, if: { type: :full }
end


