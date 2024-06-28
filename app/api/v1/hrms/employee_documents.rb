class V1::Hrms::EmployeeDocuments < Grape::API
  before { authenticate_user! }

  resources :employees do
    route_param :employee_id do

      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "employee not found" }, 404) unless @employee
      end


      resources :employee_documents do

        # Endpoint to get all employee_documents for a specific employee----------------------------------------------------------------------------------
        desc 'Return all employee_documents for a specific employee'
        get do
          employee_documents = User.new.get_all_employee_documents(@employee)
          present employee_documents, with: V1::Entities::EmployeeDocument, type: :full
        end
      end
    end
  end
end
