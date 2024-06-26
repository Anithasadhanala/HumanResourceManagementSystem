class BaseApi < Grape::API
  before { authenticate_user! }
end