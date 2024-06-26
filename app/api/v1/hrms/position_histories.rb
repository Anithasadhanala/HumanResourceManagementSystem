class V1::Hrms::PositionHistories < Grape::API
  before {authenticate_user! }

  resources :employees do
    route_param :employee_id do
      resources :position_switch do

        # Endpoint to get all position_histories for a specific employee----------------------------------------------------------------------------------
        desc 'Return all position_histories for a specific employee'

        get do
          position_histories = User.new.get_all_position_histories(params[:employee_id])
          present position_histories, with: V1::Entities::PositionHistory
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

        # Endpoint to create a new allowance and deduction for a specific employee----------------------------------------------------------------------------
        desc 'Create a new allowance and deduction for a specific employee'
        before { authenticate_admin! }
        params do
          requires :to_role_id, type: Integer
          requires :switch_reason, type: String
          requires :switch_type, type: String
        end

        post do
          puts(params,"++++++++++++++++++++++++++++++++++++")
          position_history = PositionHistory.new.create_position_history(params)
          present position_history, with: V1::Entities::PositionHistory,  type: :full
        end

        # Endpoint to update a specific position_history for a specific employee------------------------------------------------------------------------
        desc 'Update a specific position_history for a specific employee'
        params do
          optional :type, type: String
          optional :is_deduction, type: Boolean
          optional :amount, type: Integer
          optional :is_active, type: Boolean
        end

        put ':id' do
          position_history = PositionHistory.new.find_and_update_position_history(params)
          present position_history, with: V1::Entities::PositionHistory
        end
      end
    end
  end
end
