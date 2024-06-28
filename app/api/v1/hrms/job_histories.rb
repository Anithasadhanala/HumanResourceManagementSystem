class V1::Hrms::JobHistories < Grape::API
  before { authenticate_user! }

  helpers do
    def job_history_permitted_attributes(params)
      permitted_params = ActionController::Parameters.new(params).permit(
        :from_role_id,
        :to_role_id,
        :switched_at,
        :switch_reason,
        :switch_type)
      permitted_params.merge(employee_id: params[:employee_id])
      permitted_params
    end
  end


  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end


      resources :job_histories do

      # Endpoint, gives all job histories----------------------------------------------------------------------------------------
      desc 'Return all job histories'
      params do
        optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
        optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
      end

      get do
        job_histories = Employee.new.get_all_job_histories(params[:employee_id])
        present(job_histories , with: V1::Entities::JobHistory, type: :full)
      end


      # Endpoint to get a specific job_histories by ID-------------------------------------------------------------------------------
      desc 'Return a specific job_histories'
      params do
        requires :id, type: Integer
      end

      get ':id' do
        job_history = Employee.new.get_job_history(params[:employee_id],params[:id])
        if job_history
          present job_history, with: V1::Entities::JobHistory
        end
      end


      # Endpoint for updating a specific job_history---------------------------------------------------------------------------------
      desc 'Update a job_history'
      before { authenticate_admin! }
      params do
        optional :from_role_id, type: Integer
        optional :to_role_id, type: Integer
        optional :switched_at, type: DateTime
        optional :switch_reason, type: String
        optional :switch_type, type: String
      end

      put ':id' do
        permitted_params = job_history_permitted_attributes(params)
        permitted_params =  permitted_params.merge(id: params[:id])
        permitted_params =  permitted_params.merge(employee_id: params[:employee_id])
        job_history = JobHistory.new.find_and_update_job_history(permitted_params)
        present job_history, with: V1::Entities::JobHistory
      end


    end
    end
  end
end