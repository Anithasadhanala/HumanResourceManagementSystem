class V1::Hrms::AllowanceAndDeductions < Grape::API
  before {authenticate_user! }

  helpers do
    def allowance_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :compensation_type,
        :amount,
        :is_deduction,
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


      resources :allowance_and_deductions do

        # Endpoint to get all allowance_and_deductions for a specific employee----------------------------------------------------------------------------------
        desc 'Return all allowance_and_deductions for a specific employee'
        get do
          allowance_and_deductions = User.new.get_all_allowance_and_deductions(params[:employee_id])
          present allowance_and_deductions, with: V1::Entities::AllowanceAndDeduction
        end


        # Endpoint to get a specific allowance_and_deduction by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific allowance_and_deduction for a specific employee'
        get ':id' do
          allowance_and_deduction = User.new.get_allowance_and_deduction(params[:employee_id], params[:id])
          present allowance_and_deduction, with: V1::Entities::AllowanceAndDeduction
        end


        # Endpoint to create a new allowance and deduction for a specific employee----------------------------------------------------------------------------
        desc 'Create a new allowance and deduction for a specific employee'
        before { authenticate_admin! }
        params do
          requires :compensation_type, type: String
          requires :amount, type: Integer
          requires :is_deduction, type: Boolean
          optional :is_active, type: Boolean, default: true
        end

        post do
          permitted_params =  allowance_permitted_attributes(params)
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          allowance_and_deduction = AllowanceAndDeduction.new.create_allowance_and_deduction(permitted_params)
          present allowance_and_deduction, with: V1::Entities::AllowanceAndDeduction,  type: :full
        end


        # Endpoint to update a specific allowance_and_deduction for a specific employee------------------------------------------------------------------------
        desc 'Update a specific allowance_and_deduction for a specific employee'
        params do
          optional :type, type: String
          optional :is_deduction, type: Boolean
          optional :amount, type: Integer
          optional :is_active, type: Boolean
        end

        put ':id' do
          permitted_params =  allowance_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          allowance_and_deduction = AllowanceAndDeduction.new.find_and_update_allowance_and_deduction(permitted_params)
          present allowance_and_deduction, with: V1::Entities::AllowanceAndDeduction
        end

        # Endpoint to delete a specific address for a specific employee----------------------------------------------------------------------------
        desc 'Delete a specific allowance and deduction for a specific employee'
        params do
          requires :id, type: Integer
        end

        delete ':id' do
          allowance_and_deduction = AllowanceAndDeduction.new.find_and_destroy_employee_allowance_and_deduction(params[:employee_id], params[:id])
          allowance_and_deduction
        end
      end
    end
  end
end
