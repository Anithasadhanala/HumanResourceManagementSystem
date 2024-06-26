class PositionHistory < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'employee_id'


  def create_position_history(params)
    employee = Employee.new.update_employee_job_position(params)
    if employee

      params = params.merge(from_role_id: employee.job_position_id)
      puts("))))))))))))))))))))))))))))))))))))))",params)
      PositionHistory.create!(params)
    else
      raise RuntimeError, {message: "dfghjfvbhjkxcvbnmxcvbn"}
    end
  end





end