class V1::Hrms::BankCredentials < Grape::API
  before { authenticate_user! }

  helpers do
    # accepts params and returns, restricted params
    def bank_credentials_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :bank_name,
        :bank_branch,
        :account_number,
        :ifsc_code,
        :bank_branch_code,
        :account_type,
        :is_active)
    end
  end


  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end



      resources :bank_credentials do

        # Endpoint to get all bank_credentials for a specific employee----------------------------------------------------------------------------------
        desc 'Return all bank_credentials for a specific employee'
        get do
          bank_credentials = Employee.new.get_all_bank_credentials(params[:employee_id])
          present bank_credentials, with: V1::Entities::BankCredential, type: :full
        end


        # Endpoint to get a specific bank_credential by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific bank_credential for a specific employee'

        get ':id' do
          bank_credential = Employee.new.get_bank_credential(params[:employee_id], params[:id])
          present bank_credential, with: V1::Entities::BankCredential,  type: :full
        end


        # Endpoint to create a new Bank Credential for a specific employee----------------------------------------------------------------------------
        desc 'Create a new Bank Credential for a specific employee'
        params do
          requires :bank_name, type: String
          requires :bank_branch, type: String
          requires :account_number, type: String
          requires :ifsc_code, type: String
          requires :bank_branch_code, type: String
          requires :account_type, type: String
          optional :is_active, type: Boolean, default: true
        end

        post do
          permitted_params = bank_credentials_permitted_attributes(params)
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          bank_credential = BankCredential.new.create_bank_credential(permitted_params)
          present bank_credential, with: V1::Entities::BankCredential,  type: :full
        end


        # Endpoint to update a specific bank_credential for a specific employee------------------------------------------------------------------------
        desc 'Update a specific bank_credential for a specific employee'
        params do
          optional :bank_name, type: String
          optional :bank_branch_place, type: String
          optional :account_number, type: String
          optional :ifsc_code, type: String
          optional :bank_branch_code, type: String
          optional :account_type, type: String
          optional :is_active, type: Boolean, default: true
        end

        put ':id' do
          permitted_params = bank_credentials_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          bank_credential = BankCredential.new.find_and_update_bank_credential(permitted_params)
          present bank_credential, with: V1::Entities::BankCredential
        end


        # Endpoint to delete a specific address for a specific employee----------------------------------------------------------------------------
        desc 'Delete a specific address for a specific employee'
        params do
          requires :id, type: Integer
        end

        delete ':id' do
          bank_credential = BankCredential.new.find_and_destroy_employee_bank_credential(params[:employee_id], params[:id])
          bank_credential
        end
      end
    end
  end
end
