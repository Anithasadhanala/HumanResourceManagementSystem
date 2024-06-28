class V1::Hrms::Leaves < Grape::API
  before { authenticate_user! }

  helpers do
    def leave_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :title,
        :days_count,
        :description)
    end
  end

  resources :leaves do


    # Endpoint, gives all leaves----------------------------------------------------------------------------------------
    desc 'Return all leaves'
    params do
      optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
    end

    get do
      leaves = Leave.new.get_all_leaves
      leaves = paginate(leaves)
      present(leaves , with: V1::Entities::Leave, type: :full)
    end


    # Endpoint to get a specific Leave by ID-------------------------------------------------------------------------------
    desc 'Return a specific Leave'
    params do
      requires :id, type: Integer
    end

    get ':id' do
      leave = Leave.new.find_by_id(params[:id])
      present leave, with: V1::Entities::Leave
    end


    # Endpoint to create a new Leave---------------------------------------------------------------------------------------
    desc 'Create a new Leave'
    before { authenticate_admin! }
    params do
      requires :title, type: String
      requires :description, type: String
    end

    post do
      permitted_params = leave_permitted_attributes(params)
      leave = Leave.new.create_leave(permitted_params)
      present leave, with: V1::Entities::Leave, type: :full
    end


    # Endpoint for updating a specific Leave---------------------------------------------------------------------------------
    desc 'Update a Leave'
    params do
      optional :name, type: String
      optional :description, type: String
    end

    put ':id' do
      permitted_params = leave_permitted_attributes(params)
      permitted_params = permitted_params.merge(id: params[:id])
      leave = Leave.new.find_and_update_leave(permitted_params)
      present leave, with: V1::Entities::Leave
    end


    # Endpoint that deletes a specific Leave ----------------------------------------------------------------------------------
    desc 'Delete a Leave'
    params do
      requires :id, type: Integer
    end

    delete ':id' do
      leave= Leave.new.find_and_destroy(params[:id])
      leave
    end
  end
end