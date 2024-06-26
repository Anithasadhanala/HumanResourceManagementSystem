module AuthenticationHelper

  def authenticate_user!
     error!('Unauthorized user', 401) unless current_user
  end

  def authenticate_admin!
     error!('Unauthorized admin', 401) unless Current.user.role == "admin"
  end

  def current_user
    header = request.headers['authorization']
    token = header.split(' ').last if header
    return error!('Unauthorized', 401) unless token

    begin
      payload, _header = JWT.decode(token, nil, false)
      if payload['expiry'] && Time.at(payload['expiry']) < Time.now
        return error!('Token has expired', 401)
      end

      # Check if the token is blacklisted
      if UserJwtToken.exists?(jwt_token: token, is_active: false)
        error!('Token is deleted', 401)
      else
        data = JWT.decode(token, "SECRET", true, { algorithm: 'HS256' })
        Current.user = User.find(data[0]['user_id'])
        @current_jwt_token = token
      end
    end
  end

  def current_jwt_token
    @current_jwt_token
  end
end
