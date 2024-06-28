class V1::Hrms::LeaveRequests < Grape::API
  before { authenticate_user! }

  helpers do
    def leave_request_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :leave_id,
        :start_date,
        :end_date,
        :working_days_covered,
      :status)
    end
  end


  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end


      resources :leave_requests do

        # Endpoint, gives all leave requests----------------------------------------------------------------------------------------
        desc 'Return all leave requests'
        params do
          optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
          optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
        end

        get do
          leave_requests = User.new.get_all_leave_requests(@employee.id)
          present(leave_requests , with: V1::Entities::LeaveRequest, type: :full)
        end


        # Endpoint to get a specific leave_requests by ID-------------------------------------------------------------------------------
        desc 'Return a specific leave_requests'

        get ':id' do
          leave_request = User.new.get_leave_request(@employee.id,params[:id])
          if leave_request
            present leave_request, with: V1::Entities::LeaveRequest
          end
        end


        # Endpoint to create a new leave_request---------------------------------------------------------------------------------------
        desc 'Create a new leave_request'

        params do
          requires :leave_id, type: Integer
          requires :start_date, type: Date
          requires :end_date, type: Date
          requires :working_days_covered, type: Integer
        end

        post do
          permitted_params = leave_request_permitted_attributes(params)
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          leave_request = LeaveRequest.new.create_leave_request(permitted_params)
          present leave_request, with: V1::Entities::LeaveRequest, type: :full
        end


        # Endpoint for updating a specific leave_request---------------------------------------------------------------------------------
        desc 'Update a leave_request'
        params do
          optional :start_date, type: Date
          optional :end_date, type: Date
          optional :working_days_covered, type: Integer
          optional :status, type: String
        end

        put ':id' do
          permitted_params = leave_request_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          permitted_params = permitted_params.merge(employee_id: params[:employee_id])
          leave_request = LeaveRequest.new.find_and_update_leave_request(permitted_params)
          # present leave_request, with: V1::Entities::LeaveRequest
        end
      end


      resources :leaves do

        # Endpoint to get for a specific employee, leave - counts  by ID-------------------------------------------------------------------------------
        desc 'Return a specific leave_requests'
        get do
          User.new.get_leave_details(params[:employee_id])
          end
      end
    end
  end
end

