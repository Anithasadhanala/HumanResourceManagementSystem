class V1::Hrms::Employees < BaseApi
  before { authenticate_user! }

  resources :employees do

    # Endpoint to get a specific employee by ID-------------------------------------------------------------------------------
    desc 'Return a specific employee'

    params do
      requires :id, type: Integer
    end

    get ':id' do
      employee = Employee.new.find_by_id(params[:id])
      if employee
        present employee, with: V1::Entities::Employee
      end
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
      employee = Employee.new.find_and_update_employee(params)
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