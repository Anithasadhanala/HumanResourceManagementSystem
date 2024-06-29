class V1::Hrms::EmployeeDocuments < Grape::API
  before { authenticate_user! }

      resources :employee_documents do

        # Endpoint to get all employee_documents for a specific employee----------------------------------------------------------------------------------
        desc 'Return all employee_documents for a specific employee'
        params do
          optional :employee_id, type: Integer
        end
        get do
          employee_documents = User.new.get_all_employee_documents(params[:employee_id])
          present employee_documents, with: V1::Entities::EmployeeDocument, type: :full
        end
      end
    end

