class V1::Hrms::Departments <  Grape::API
  before { authenticate_user! }

  helpers do
    def department_permitted_attributes(params)
      ActionController::Parameters.new(params).permit(
        :name,
        :description)
    end
  end

  resources :departments do

    # accepts params and returns, restricted params


    # Endpoint, gives all departments----------------------------------------------------------------------------------------
    desc 'Return all departments'
    params do
      optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
    end

    get do
      departments = Department.new.get_all_departments
      departments = paginate(departments)
      present(departments , with: V1::Entities::Department, type: :full)
    end


    # Endpoint to get a specific department by ID-------------------------------------------------------------------------------
    desc 'Return a specific department'
    params do
      requires :id, type: Integer
    end

    get ':id' do
      department = Department.new.find_by_id(params[:id])
      present department, with: V1::Entities::Department
    end


    # Endpoint to create a new department---------------------------------------------------------------------------------------
    desc 'Create a new department'
    before { authenticate_admin! }
    params do
      requires :name, type: String
      requires :description, type: String
    end

    post do
      permitted_params = department_permitted_attributes(params)
      department = Department.new.create_department(permitted_params)
      present department, with: V1::Entities::Department, type: :full
    end


    # Endpoint for updating a specific department---------------------------------------------------------------------------------
    desc 'Update a department'

    params do
      optional :name, type: String
      optional :description, type: String
    end

    put ':id' do
      permitted_params = department_permitted_attributes(params)
      permitted_params = permitted_params.merge(id: params[:id])
      department = Department.new.find_and_update_department(permitted_params)
      present department, with: V1::Entities::Department
    end


    # Endpoint that deletes a specific department ----------------------------------------------------------------------------------
    desc 'Delete a department'
    params do
      requires :id, type: Integer
    end

    delete ':id' do
      department= Department.new.find_and_destroy_if_no_employees(params[:id])
      department
    end
  end
end