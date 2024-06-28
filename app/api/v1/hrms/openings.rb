class V1::Hrms::Openings < Grape::API
  before { authenticate_user! }

  helpers do
    def opening_permitted_attributes(params)
       ActionController::Parameters.new(params).permit(
        :required_qualifications,
        :max_salary,
        :min_salary,
        :openings_count,
        :occupancy_count,
        :job_position_id,
        :employment_type)
    end
  end

  resources :job_positions do
    route_param :job_position_id do

      before do
        @job_position = JobPosition.find_by(id: params[:job_position_id], is_active:true)
        error!({ error: "JobPosition not found" }, 404) unless @job_position
      end


    resources :openings do

    # Endpoint, gives all openings----------------------------------------------------------------------------------------
    desc 'Return all openings'
    params do
      optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
    end

    get do
      openings = JobPosition.new.get_all_active_openings_of_jobPosition(@job_position)
      openings = paginate(openings)
      present(openings , with: V1::Entities::Opening, type: :full)
    end


    # Endpoint to get a specific Opening by ID-------------------------------------------------------------------------------
    desc 'Return a specific Opening'
    params do
      requires :id, type: Integer
    end

    get ':id' do
      opening = JobPosition.new.find_opening_by_id(@job_position,params[:id])
      present opening, with: V1::Entities::Opening
    end


    # Endpoint to create a new Opening---------------------------------------------------------------------------------------
    desc 'Create a new Opening'
    before { authenticate_admin! }
    params do
      requires :required_qualifications, type: String
      requires :max_salary, type: Integer
      requires :min_salary, type: Integer
      requires :employment_type, type: String
    end

    post do
      permitted_params = opening_permitted_attributes(params)
      permitted_params = permitted_params.merge(job_position_id: params[:job_position_id])
      opening = Opening.new.create_opening(permitted_params)
      present opening, with: V1::Entities::Opening, type: :full
    end


    # Endpoint for updating a specific Opening---------------------------------------------------------------------------------
    desc 'Update a Opening'
    params do
      optional :required_qualifications, type: String
      optional :max_salary, type: Integer
      optional :min_salary, type: Integer
      optional :openings_count, type: Integer
      optional :employment_type, type: String
    end

    put ':id' do
      permitted_params = opening_permitted_attributes(params)
      permitted_params = permitted_params.merge(id: params[:id])
      permitted_params.merge(job_position_id: params[:job_position_id])
      opening = Opening.new.find_and_update_opening(permitted_params)
      present opening, with: V1::Entities::Opening
    end
    end
    end
  end
end
