class V1::Hrms::PositionHistories < Grape::API
  before {authenticate_user! }

  helpers  do
    def position_history_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :switch_type,
        :joined_at,
        :job_position_id,
       :switch_type,
        :employee_id)
    end
  end

      resources :position_histories do

        # Endpoint to get all position_histories for a specific employee----------------------------------------------------------------------------------
        desc 'Return all position_histories for a specific employee'
        params do
          optional :employee_id, type: Integer
        end
        get do
          position_histories = User.new.get_all_position_histories(params[:employee_id])
          present position_histories, with: V1::Entities::PositionHistory, type: :full
        end


        # Endpoint to get a specific position_history by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific position_history for a specific employee'
        params do
          optional :employee_id, type: Integer
        end

        get ':id' do
          position_history = User.new.get_position_history(params[:id],params[:employee_id])
          present position_history, with: V1::Entities::PositionHistory,  type: :full
        end


        # Endpoint to update a specific position_history for a specific employee------------------------------------------------------------------------
        desc 'create a specific position_history for a specific employee'
        before {authenticate_admin! }
        params do
          requires :switch_type, type: String
          requires :joined_at, type: Date
          requires :job_position_id, type: Integer
          requires :switch_type, type: String
          requires :employee_id, type: Integer
        end

        post  do
          permitted_params = position_history_permitted_attributes(params)
          position_history = PositionHistory.new.employee_job_switch(permitted_params)
          present position_history, with: V1::Entities::PositionHistory, type: :full
        end
      end
    end

