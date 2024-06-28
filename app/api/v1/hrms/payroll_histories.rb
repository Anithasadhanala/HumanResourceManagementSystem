class V1::Hrms::PayrollHistories < Grape::API
  before {authenticate_user! }

  resources :employees do
    route_param :employee_id do

      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end

      resources :credit_payrolls do

        # Endpoint to get all payroll_histories for a specific employee----------------------------------------------------------------------------------
        desc 'Return all payroll_histories for a specific employee'
        get do
          payroll_histories = User.new.get_all_payroll_histories(params[:employee_id])
          present payroll_histories, with: V1::Entities::PayrollHistory, type: :full
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
          payroll_history = PayrollHistory.new.create_payroll_history(params)
          present payroll_history, with: V1::Entities::PayrollHistory,  type: :full
        end
      end
    end
  end
end
