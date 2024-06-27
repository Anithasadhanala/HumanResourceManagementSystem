class V1::Hrms::LeaveRequests < Grape::API
  before { authenticate_user! }
  resources :employees do
    route_param :employee_id do
      resources :leave_requests do

        # Endpoint, gives all leave requests----------------------------------------------------------------------------------------
        desc 'Return all leave requests'

        params do
          optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
          optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
        end

        get do
          leave_requests = User.new.get_all_leave_requests(params[:employee_id])
          present(leave_requests , with: V1::Entities::LeaveRequest, type: :full)
        end

        # Endpoint to get a specific leave_requests by ID-------------------------------------------------------------------------------
        desc 'Return a specific leave_requests'

        params do
          requires :id, type: Integer
        end

        get ':id' do
          leave_request = User.new.get_leave_request(params[:employee_id],params[:id])
          if leave_request
            present leave_request, with: V1::Entities::LeaveRequest
          end
        end

        # Endpoint to create a new leave_request---------------------------------------------------------------------------------------
        desc 'Create a new leave_request'
        before { authenticate_admin! }
        params do
          requires :leave_id, type: Integer
          requires :start_date, type: Date
          requires :end_date, type: Date
          requires :working_days_covered, type: Integer
        end

        post do
          leave_request = LeaveRequest.new.create_leave_request(params)
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
          leave_request = LeaveRequest.new.find_and_update_leave_request(params)
          present leave_request
        end
      end
    end
  end
  end
