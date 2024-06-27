class V1::Hrms::Hikes < Grape::API
  before {authenticate_user! }

  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end

      def hike_permitted_attributes(params)
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


      resources :hikes do

        # Endpoint to get a specific hike by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific hike for a specific employee'
        params do
          requires :id, type: Integer
        end

        get ':id' do
          hike = User.new.get_hike(params[:employee_id], params[:id])
          present hike, with: V1::Entities::Hike
        end


        # Endpoint to create a new allowance and deduction for a specific employee----------------------------------------------------------------------------
        desc 'Create a new allowance and deduction for a specific employee'
        before { authenticate_admin! }
        params do
          requires :reason, type: String
          requires :percentage_value, type: Integer
        end

        post do
          permitted_params = hike_permitted_attributes(params)
          hike = Hike.new.create_hike(permitted_params)
          present hike, with: V1::Entities::Hike,  type: :full
        end


        # Endpoint to update a specific hike for a specific employee------------------------------------------------------------------------
        desc 'Update a specific hike for a specific employee'
        params do
          optional :reason, type: String
          optional :percentage_value, type: Integer
        end

        put ':id' do
          permitted_params = hike_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          hike = Hike.new.find_and_update_hike(permitted_params)
          present hike, with: V1::Entities::Hike
        end


        # Endpoint to delete a specific address for a specific employee----------------------------------------------------------------------------
        desc 'Delete a specific allowance and deduction for a specific employee'
        params do
          requires :id, type: Integer
        end

        delete ':id' do
          hike = Hike.new.find_and_destroy_employee_hike(id, @employee.id)
          hike
        end


      end
    end
  end
end
