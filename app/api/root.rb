
# Ensure the correct path to the ExceptionHandler module

class Root < Grape::API
  format :json

  helpers PaginationHelper
  include V1::Exceptions::ExceptionHandler

  mount V1::Hrms::Users
  mount V1::Hrms::Departments
  mount V1::Hrms::JobPositions
  mount V1::Hrms::Addresses
  mount V1::Hrms::BankCredentials
end