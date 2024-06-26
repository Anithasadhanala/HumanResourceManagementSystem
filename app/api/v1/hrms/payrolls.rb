class V1::Hrms::Payrolls < BaseApi
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

    params do
      optional :base_payroll, type: String
    end

    put ':id' do
      payroll = Payroll.new.find_and_update_payroll(params)
      present payroll, with: V1::Entities::Payroll
    end
    
  end
end