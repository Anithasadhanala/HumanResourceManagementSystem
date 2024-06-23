class V1::Hrms::Users < Grape::API
  format :json


  resource :users do

    desc 'signup a new user'

    params do
      requires :role, type: String
      requires :employees_attributes, type: Hash do
        requires :user_name, :first_name, :last_name,:phone, :hired_at, :personal_email, :emergency_contact_phone,
                 :emergency_contact_name, :gender, :experience_in_months, :qualifications, :employee_type, :employment_type
      end
    end

    post :signup do
      begin
        user = User.new.create_user(params)
        present user
      end
    end























    # Login  Endpoint of  a user ------------------------------------------------------------------------------------------------------------------
    desc 'Login user'
    params do
      requires :email, type: String
      requires :password, type: String
    end

    post :login do
      user = User.find_by(email: params[:email])
      user_role = user.role
      if user && user.authenticate(params[:password]) && User.roles[user_role] == User.roles[:buyer]

        # Check for an existing valid JWT token, if exists then check for the unexpired token
        user_valid_token = UserJwtToken.new.get_valid_token(user.id)
        if user_valid_token
          present user_valid_token, with: V1::Entities::Login
        else
          user_jwt = UserJwtToken.new.generate_jwt_token_and_store(user.id)
          present user_jwt, with: V1::Entities::Login
        end
      end
    end


    #Logout Endpoint of a user -------------------------------------------------------------------------------------------------------------------
    desc  'Logout user'
    before { authenticate_user! }
    delete :logout do
      if Current.user
        jwt_record.update!(is_active: false)
        { message: 'Logout successful' }
      end
    end
  end
end
