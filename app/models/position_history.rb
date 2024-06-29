class PositionHistory < ApplicationRecord

  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'

  def employee_job_switch(params)
    Employee.new.update_employee_job_position(params)
    PositionHistory.create!(params)
  end
end