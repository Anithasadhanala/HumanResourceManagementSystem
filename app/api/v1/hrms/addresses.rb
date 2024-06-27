class V1::Hrms::Addresses < Grape::API
  before { authenticate_user! }


  resources :employees do
    route_param :employee_id do

      # validating provided employee exists
      before do
        @employee = User.find_by(id: params[:employee_id])
        error!({ error: "Employee not found" }, 404) unless @employee
      end


      # accepts params and returns, restricted params
      def address_permitted_attributes(params)
        permitted_params = ActionController::Parameters.new(params).permit(
          :d_no,
          :landmark,
          :city,
          :zip_code,
          :country,
          :is_permanent)
        permitted_params.merge(employee_id: params[:employee_id])
        permitted_params
      end


      resources :addresses do

        # Endpoint to get all addresses for a specific employee----------------------------------------------------------------------------------
        desc 'Return all addresses for a specific employee'
        get do
          addresses = Address.new.get_all_addresses(params[:employee_id])
          present addresses, with: V1::Entities::Address, type: :full
        end


        # Endpoint to get a specific address by ID for a specific employee----------------------------------------------------------------------
        desc 'Return a specific address for a specific employee'
        params do
          requires :id, type: Integer
        end
        get ':id' do
          address = Address.new.find_by_id(params[:employee_id], params[:id])
          present address, with: V1::Entities::Address
        end


        # Endpoint to create a new address for a specific employee----------------------------------------------------------------------------
        desc 'Create a new address for a specific employee'
        params do
          requires :d_no, type: String
          requires :landmark, type: String
          requires :city, type: String
          requires :zip_code, type: String
          requires :state, type: String
          requires :country, type: String
          requires :is_permanent, type: Boolean
        end

        post do
          permitted_params = address_permitted_attributes(params)
          address = Address.new.create_address(permitted_params)
          present address, with: V1::Entities::Address, type: :full
        end


        # Endpoint to update a specific address for a specific employee------------------------------------------------------------------------
        desc 'Update a specific address for a specific employee'
        params do
          optional :d_no, type: String
          optional :landmark, type: String
          optional :city, type: String
          optional :zip_code, type: String
          optional :state, type: String
          optional :country, type: String
          optional :is_permanent, type: Boolean
        end

        put ':id' do
          permitted_params = address_permitted_attributes(params)
          permitted_params = permitted_params.merge(id: params[:id])
          address = Address.new.find_and_update_address(permitted_params)
          present address, with: V1::Entities::Address
        end

        # Endpoint to delete a specific address for a specific employee----------------------------------------------------------------------------
        desc 'Delete a specific address for a specific employee'

        params do
          requires :id, type: Integer
        end
        delete ':id' do
          address = Address.new.find_and_destroy_employee_address(params[:employee_id], params[:id])
          address
        end
      end
    end
  end
end
