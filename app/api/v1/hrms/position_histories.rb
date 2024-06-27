class V1::Hrms::PositionHistories < Grape::API
  before {authenticate_user! }

  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end

      def position_history_permitted_attributes(params)
        permitted_params = ActionController::Parameters.new(params).permit(
          :reason,
          :percentage_value,
          :account_number,
          :ifsc_code,
          :bank_branch_code,
          :account_type,
          :is_active)
        permitted_params.merge(employee_id: params[:employee_id])
        permitted_params
      end


      resources :position_switch do

        # Endpoint to get all position_histories for a specific employee----------------------------------------------------------------------------------
        desc 'Return all position_histories for a specific employee'

        get do
          position_histories = User.new.get_all_position_histories(params[:employee_id])
          present position_histories, with: V1::Entities::PositionHistory, type: :full
        end


        # Endpoint to get a specific position_history by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific position_history for a specific employee'
        params do
          requires :id, type: Integer
        end

        get ':id' do
          position_history = User.new.get_position_history(params[:employee_id], params[:id])
          present position_history, with: V1::Entities::PositionHistory
        end


        # Endpoint to update a specific position_history for a specific employee------------------------------------------------------------------------
        desc 'Update a specific position_history for a specific employee'
        before {authenticate_user! }
        params do
          optional :to_role_id, type: Integer
          optional :switch_reason, type: String
          optional :switch_type, type: String
        end

        put ':id' do
          permitted_params = position_history_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          position_history = PositionHistory.new.find_and_update_position_history(permitted_params)
          present position_history, with: V1::Entities::PositionHistory
        end
      end
    end
  end
end
