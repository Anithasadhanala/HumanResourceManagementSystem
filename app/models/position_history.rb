class PositionHistory < ApplicationRecord

  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  def job_switch_from_role_to_role(params)
    employee_instance = Employee.find(params[:employee_id])
    Employee.new.update_employee_job_position(params)
    params = params.merge(from_role_id: employee_instance.job_position_id)
    PositionHistory.create!(params)
  end
end