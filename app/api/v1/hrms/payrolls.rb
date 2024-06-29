class V1::Hrms::Payrolls <  Grape::API
  before { authenticate_user! }

  resources :payrolls do

    # Endpoint, gives all payrolls----------------------------------------------------------------------------------------
    desc 'Return all payrolls'
    before { authenticate_admin! }
    params do
      optional :page, type: Integer, default: DEFAULT_PAGE, desc: 'Page number for pagination'
      optional :per_page, type: Integer, default: DEFAULT_PER_PAGE, desc: 'Number of products per page'
    end

    get do
      payrolls = Payroll.new.get_all_payrolls
      payrolls = paginate(payrolls)
      present(payrolls , with: V1::Entities::Payroll, type: :full)
    end
    

    # Endpoint for updating a specific Payroll---------------------------------------------------------------------------------
    desc 'Update a Payroll'
    before { authenticate_admin! }
    params do
      requires :base_payroll, type: String
      requires  :employee_id, type: Integer
    end

    put ':id' do
      permitted_params = ActionController::Parameters.new(params).permit(
        :base_payroll)
      permitted_params = permitted_params.merge(id: params[:id])
      payroll = Payroll.new.find_and_update_payroll(permitted_params)
      present payroll, with: V1::Entities::Payroll
    end
  end
end