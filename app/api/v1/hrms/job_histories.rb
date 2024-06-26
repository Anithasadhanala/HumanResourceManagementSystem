class V1::Hrms::JobHistories < Grape::API
  before { authenticate_user! }

  resources :employees do
    route_param :employee_id do
    resources :jobhistories do

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

      params do
        optional :from_role_id, type: Integer
        optional :to_role_id, type: Integer
        optional :switched_at, type: DateTime
        optional :switch_reason, type: String
        optional :switch_type, type: String
      end

      put ':id' do
        job_history = JobHistory.new.find_and_update_job_history(params)
        present job_history, with: V1::Entities::JobHistory
      end
    end

    end
  end
end