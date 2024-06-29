class V1::Hrms::PayrollHistories < Grape::API
  before {authenticate_user! }



      resources :credit_payrolls do

        # Endpoint to get all payroll_histories for a specific employee----------------------------------------------------------------------------------
        desc 'Return all payroll_histories for a specific employee'

        params do
          optional :employee_id, type: Integer
        end
        get do
          payroll_histories = User.new.get_all_payroll_histories(params[:employee_id])
          present payroll_histories, with: V1::Entities::PayrollHistory, type: :full
        end


        # Endpoint to get a specific payroll_history by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific payroll_history for a specific employee'
        params do
          optional :employee_id, type: Integer
        end
        get ':id' do
          payroll_history = User.new.get_payroll_history(params[:id],params[:employee_id])
          present payroll_history, with: V1::Entities::PayrollHistory
        end


        # Endpoint to create a new allowance and deduction for a specific employee----------------------------------------------------------------------------
        desc 'Create a new payroll histories for a specific employee'
        before { authenticate_admin! }
        params do
          requires :bank_credential_id, type: Integer
          requires :employee_id, type: Integer
        end

        post do
          payroll_history = PayrollHistory.new.create_payroll_history(params)
          present payroll_history, with: V1::Entities::PayrollHistory,  type: :full
        end
      end
    end

