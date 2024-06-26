class V1::Entities::User < Grape::Entity
  expose :id,  if: {type: :full}
  expose :email
  expose :password_digest
  expose :role


end


