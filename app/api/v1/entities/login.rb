
class V1::Entities::Login < Grape::Entity
  expose :jwt_token
  expose :user do |token, options|
    user = User.find(token.user_id)
    {
      email: user.email,
      role: user.role
    }
  end
end

