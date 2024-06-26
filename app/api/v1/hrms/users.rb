class V1::Hrms::Users < Grape::API
  format :json

  resource :users do
    desc 'signup a new user'

    params do
      requires :email, type: String
      requires :password, type: String
      requires :role, type: String

      requires :addresses_attributes, type: Hash do
        requires :d_no, type: String
        requires :landmark, type: String
        requires :city, type: String
        requires :zip_code, type: String
        requires :state, type: String
        requires :country, type: String
        optional :is_active, type: Boolean, default: true
        optional :is_permanent, type: Boolean, default: true
      end

      requires :employee_attributes, type: Hash do
        requires :user_name,type: String
        requires :first_name, type: String
        requires  :last_name,type: String
        requires :phone,type: String
        requires :hired_at, type: String
        requires :personal_email ,type: String
        requires :emergency_contact_phone,type: String
        requires  :emergency_contact_name,type: String
        requires :gender,type: String
        requires :experience_in_months,type: String
        requires :qualifications,type: String
        requires :employee_type,type: String
        requires :employment_type,type: String
        requires :job_position_id, type: Integer
        requires :department_id, type: Integer
        end

      requires :employee_supervisors_attributes, type: Hash do
        requires :supervisor_id, type: Integer
        requires :secondary_supervisor_id, type: Integer
      end

      requires :bank_credentials_attributes, type: Hash do
        requires :bank_name, type: String
        requires :bank_branch, type: String
        requires :account_number, type: String
        requires :ifsc_code, type: String
        requires :bank_branch_code, type: String
        requires :account_type, type: String
        optional :is_active, type: Boolean, default: true
      end

      requires :payroll_attributes, type: Hash do
        requires :base_payroll, type: Integer
      end
    end

    post :signup do
      begin
        user = User.new.create_user(params)
        present user, with: V1::Entities::User, type: :full
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
      if user && user.authenticate(params[:password])
        user_valid_token = UserJwtToken.new.get_valid_token(user.id)
        if user_valid_token
          present user_valid_token, with: V1::Entities::Login
        else
          user_jwt = UserJwtToken.new.generate_jwt_token_and_store(user.id,user_role)
          present user_jwt, with: V1::Entities::Login
        end
      end
    end


    #Logout Endpoint of a user -------------------------------------------------------------------------------------------------------------------
    desc  'Logout user'
    before { authenticate_user! }
    delete :logout do
      if Current.user
        Current.user.user_jwt_tokens.update_all(is_active: false)
        { message: 'Logout successful' }
      else
        { message: 'Not logged in' }
      end
    end

  end
end
