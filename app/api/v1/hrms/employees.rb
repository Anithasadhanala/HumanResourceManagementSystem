class V1::Hrms::Employees <  Grape::API
  before { authenticate_user! }

  helpers do
    def employee_details_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :user_name,
        :phone,
        :hired_at,
        :personal_email,
        :emergency_contact_phone,
        :emergency_contact_name,
        :gender,
        :experience_in_months,
        :qualifications,
        :employee_type,
        :employment_type,
        :department_id,
        :first_name,
        :last_name
      )
    end
  end

  resources :employees do

    # Endpoint to get a specific employee by ID-------------------------------------------------------------------------------
    desc 'Return a specific employee'

    get ':id' do
      employee = Employee.new.find_by_id(params[:id])
      present employee, with: V1::Entities::Employee
    end


    # Endpoint for updating a specific employee---------------------------------------------------------------------------------



    desc 'Update a employee'

    params do
        optional :user_name, type: String
        optional :phone, type: String
        optional :hired_at, type: DateTime
        optional :personal_email, type: String
        optional :emergency_contact_phone, type: String
        optional :emergency_contact_name, type: String
        optional :gender, type: String
        optional :experience_in_months, type: Integer
        optional :qualifications, type: String
        optional :employee_type, type: String
        optional :employment_type, type: String
        optional :department_id, type: Integer
        optional :first_name, type: String
        optional :last_name, type: String
      end

    put ':id' do
      permitted_params = employee_details_permitted_attributes(params)
      permitted_params = permitted_params.merge(id: params[:id])
      employee = Employee.new.find_and_update_employee(permitted_params)
      present employee, with: V1::Entities::Employee
    end


    # Delete a specific user-------------------------------------------------------------------------
    before { authenticate_admin! }
    delete ':id' do
      delete = User.new.delete_employee(params[:id])
      delete
    end


  end
end