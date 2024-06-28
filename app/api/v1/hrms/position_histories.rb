class V1::Hrms::PositionHistories < Grape::API
  before {authenticate_user! }

  helpers  do
    def position_history_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
         :to_role_id,
       :switch_reason,
       :switch_type)
    end
  end

  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
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

        get ':id' do
          position_history = User.new.get_position_history(params[:employee_id], params[:id])
          present position_history, with: V1::Entities::PositionHistory
        end


        # Endpoint to update a specific position_history for a specific employee------------------------------------------------------------------------
        desc 'Update a specific position_history for a specific employee'
        before {authenticate_admin! }
        params do
          optional :to_role_id, type: Integer
          optional :switch_reason, type: String
          optional :switch_type, type: String
        end

        post  do
          permitted_params = position_history_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          position_history = PositionHistory.new.job_switch_from_role_to_role(permitted_params)
          present position_history, with: V1::Entities::PositionHistory, type: :full
        end
      end
    end
  end
end
