class V1::Hrms::JobPositions < Grape::API
  before { authenticate_user! }

  resources :jobpositions do

    # Endpoint, gives all job positions----------------------------------------------------------------------------------------
    desc 'Return all job positions'
    params do
      optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
    end

    get do
      job_positions = JobPosition.new.get_all_job_positions
      job_positions = paginate(job_positions)
      present(job_positions , with: V1::Entities::JobPosition, type: :full)
    end


    # Endpoint to get a specific job position by ID-------------------------------------------------------------------------------
    desc 'Return a specific job positions'

    params do
      requires :id, type: Integer
    end

    get ':id' do
      job_position = JobPosition.new.find_by_id(params[:id])
      if job_position
        present job_position, with: V1::Entities::JobPosition
      end
    end

    # Endpoint to create a new job position---------------------------------------------------------------------------------------
    desc 'Create a new job position'
    before { authenticate_admin! }
    params do
      requires :title, type: String
      requires :description, type: String
    end

    post do
      job_position = JobPosition.new.create_job_position(params)
      present job_position, with: V1::Entities::JobPosition, type: :full
    end


    # Endpoint for updating a specific  job position---------------------------------------------------------------------------------
    desc 'Update a  job position'

    params do
      optional :title, type: String
      optional :description, type: String
    end

    put ':id' do
      job_position = JobPosition.new.find_and_update_job_position(params)
      present job_position, with: V1::Entities::JobPosition
    end


    # Endpoint that deletes a specific job_position ----------------------------------------------------------------------------------
    desc 'Delete a job position'

    params do
      requires :id, type: Integer
    end

    delete ':id' do
      job_position= JobPosition.new.find_and_destroy_if_no_employees(params[:id])
      job_position
    end

  end
end