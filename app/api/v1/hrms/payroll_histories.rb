class V1::Hrms::PayrollHistories < Grape::API
  before {authenticate_user! }

  resources :employees do
    route_param :employee_id do
      resources :credit_payroll do

        # Endpoint to get all payroll_histories for a specific employee----------------------------------------------------------------------------------
        desc 'Return all payroll_histories for a specific employee'

        get do
          payroll_histories = User.new.get_all_payroll_histories(params[:employee_id])
          present payroll_histories, with: V1::Entities::PayrollHistory
        end

        # Endpoint to get a specific payroll_history by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific payroll_history for a specific employee'
        params do
          requires :id, type: Integer
        end

        get ':id' do
          payroll_history = User.new.get_payroll_history(params[:employee_id], params[:id])
          present payroll_history, with: V1::Entities::PayrollHistory
        end

        # Endpoint to create a new allowance and deduction for a specific employee----------------------------------------------------------------------------
        desc 'Create a new allowance and deduction for a specific employee'
        before { authenticate_admin! }
        params do
          requires :bank_credential_id, type: Integer
        end

        post do
          puts(params,"++++++++++++++++++++++++++++++++++++")
          payroll_history = PayrollHistory.new.create_payroll_history(params)
          present payroll_history, with: V1::Entities::PayrollHistory,  type: :full
        end

        # Endpoint to update a specific payroll_history for a specific employee------------------------------------------------------------------------
        desc 'Update a specific payroll_history for a specific employee'
        params do
          optional :type, type: String
          optional :is_deduction, type: Boolean
          optional :amount, type: Integer
          optional :is_active, type: Boolean
        end

        put ':id' do
          payroll_history = PayrollHistory.new.find_and_update_payroll_history(params)
          present payroll_history, with: V1::Entities::PayrollHistory
        end

        # Endpoint to delete a specific address for a specific employee----------------------------------------------------------------------------
        desc 'Delete a specific allowance and deduction for a specific employee'

        params do
          requires :id, type: Integer
        end

        delete ':id' do
          payroll_history = PayrollHistory.new.find_and_destroy_employee_payroll_history(params)
          payroll_history
        end
      end
    end
  end
end
