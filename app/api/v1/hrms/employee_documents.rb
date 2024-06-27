class V1::Hrms::EmployeeDocuments < Grape::API
  before { authenticate_user! }


  resources :employees do
    route_param :employee_id do
      resources :employee_documents do

        # Endpoint to get all employee_documents for a specific employee----------------------------------------------------------------------------------
        desc 'Return all employee_documents for a specific employee'

        get do
          employee_documents = EmployeeDocument.new.get_all_employee_documents(params[:employee_id])
          present employee_documents, with: V1::Entities::EmployeeDocument, type: :full
        end


        # Endpoint to get a specific EmployeeDocument by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific EmployeeDocument for a specific employee'
        params do
          requires :id, type: Integer
        end

        get ':id' do
          EmployeeDocument = EmployeeDocument.new.find_by_id(params[:employee_id], params[:id])
          present EmployeeDocument, with: V1::Entities::EmployeeDocument
        end


        # Endpoint to update a specific EmployeeDocument for a specific employee------------------------------------------------------------------------
        desc 'Update a specific EmployeeDocument for a specific employee'
        params do
          optional :d_no, type: String
          optional :landmark, type: String
          optional :city, type: String
          optional :zip_code, type: String
          optional :state, type: String
          optional :country, type: String
          optional :is_permanent, type: Boolean
        end

        put ':id' do
          EmployeeDocument = EmployeeDocument.new.find_and_update_EmployeeDocument(params)
          present EmployeeDocument, with: V1::Entities::EmployeeDocument
        end

      end
    end
  end
end
